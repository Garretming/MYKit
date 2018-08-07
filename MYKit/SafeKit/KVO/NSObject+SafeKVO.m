//
//  NSObject+SafeKVO.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/30.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSObject+SafeKVO.h"
#import "NSObject+Swizzle.h"
#import "MYSafeKitRecord.h"

#include <CommonCrypto/CommonCrypto.h>
#include <zlib.h>

static NSLock *_bmp_kvoLock;

static inline NSString *kvo_md5StringOfObject(NSObject *object) {
    NSString *string = [NSString stringWithFormat:@"%p",object];
    const char *str = string.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", buffer[i]];
    }
    return output;
}

static inline BOOL isSystemClass(Class cls) {
    __block BOOL system = NO;
    NSString *className = NSStringFromClass(cls);
    if ([className hasPrefix:@"NS"] || [className hasPrefix:@"__NS"] || [className hasPrefix:@"_UI"]) {
        system = YES;
        return system;
    }
    NSBundle *mainBundle = [NSBundle bundleForClass:cls];
    if (mainBundle == [NSBundle mainBundle]) {
        system = NO;
    } else {
        system = YES;
    }
    
    return system;
}

@interface KVOInfo : NSObject

@end

@implementation KVOInfo
{
    @package
    void *_context;
    NSKeyValueObservingOptions _options;
    __weak NSObject *_observer;
    __weak NSString *_keyPath;
    NSString *_md5Str;
}
@end


@interface XXKVOProxy : NSObject {
    NSMutableDictionary<NSString*, NSMutableArray<KVOInfo *> *> *_keyPathMaps;
}

/**
 将添加kvo时的相关信息加入到关系maps中，对应原有的添加观察者
 带成功和失败的回调
 
 @param observer observer观察者
 @param keyPath keyPath
 @param options options
 @param context context
 @param success success 成功的回调
 @param failure failure 失败的回调
 */
- (void)addKVOInfoToMapsWithObserver:(NSObject *)observer
                          forKeyPath:(NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(void *)context
                             success:(void(^)(void))success
                             failure:(void(^)(NSError *error))failure;

/**
 将添加kvo时的相关信息加入到关系maps中，对应原有的添加观察者
 不带成功和失败的回调
 @param observer 实际观察者
 @param keyPath keyPath
 @param options options
 @param context context
 @return return 是否添加成功
 */
- (BOOL)addKVOInfoToMapsWithObserver:(NSObject *)observer
                          forKeyPath:(NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(void *)context;

/**
 从关系maps中移除观察者 对应原有的移除观察者操作
 
 @param observer 实际观察者
 @param keyPath keypath
 @return 是否移除成功
 如果重复移除，会返回NO
 */
- (BOOL)removeKVOInfoInMapsWithObserver:(NSObject *)observer
                             forKeyPath:(NSString *)keyPath;

- (NSArray *)getAllKeypaths;

@end

@implementation XXKVOProxy

- (instancetype)init
{
    self = [super init];
    if (nil != self) {
        _keyPathMaps = [NSMutableDictionary dictionary];
        _bmp_kvoLock = [[NSLock alloc]init];
    }
    return self;
}

- (BOOL)addKVOInfoToMapsWithObserver:(NSObject *)observer
                          forKeyPath:(NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(void *)context{
    BOOL success;
    //先判断有没有重复添加,有的话报错，没有的话，添加到数组中
    [_bmp_kvoLock lock];
    NSMutableArray <KVOInfo *> *kvoInfos = [self getKVOInfosForKeypath:keyPath];
    __block BOOL isExist = NO;
    [kvoInfos enumerateObjectsUsingBlock:^(KVOInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj->_observer == observer) {
            isExist = YES;
        }
    }];
    if (isExist) {//已经存在了
        success = NO;
    }else{
        KVOInfo *info = [[KVOInfo alloc]init];
        info->_observer = observer;
        info->_md5Str = kvo_md5StringOfObject(observer);
        info->_keyPath = keyPath;
        info->_options = options;
        info->_context = context;
        [kvoInfos addObject:info];
        [self setKVOInfos:kvoInfos ForKeypath:keyPath];
        success = YES;
    }
    [_bmp_kvoLock unlock];
    return success;
}

- (void)addKVOInfoToMapsWithObserver:(NSObject *)observer
                          forKeyPath:(NSString *)keyPath
                             options:(NSKeyValueObservingOptions)options
                             context:(void *)context
                             success:(void(^)(void))success
                             failure:(void(^)(NSError *error))failure{
    [_bmp_kvoLock lock];
    //先判断有没有重复添加,有的话报错，没有的话，添加到数组中
    NSMutableArray <KVOInfo *> *kvoInfos = [self getKVOInfosForKeypath:keyPath];
    __block BOOL isExist = NO;
    [kvoInfos enumerateObjectsUsingBlock:^(KVOInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj->_observer == observer) {
            isExist = YES;
        }
    }];
    if (isExist) {//已经存在了
        if (failure) {
            NSInteger code = -1234;
            NSString *msg = [NSString stringWithFormat:@"\n observer重复添加:\n observer:%@\n keypath:%@ \n",observer,keyPath];
            NSError * error = [NSError errorWithDomain:@"com.BayMax.BayMaxKVODelegate" code:code userInfo:@{@"NSLocalizedDescriptionKey":msg}];
            failure(error);
        }
    }else{
        KVOInfo *info = [[KVOInfo alloc]init];
        info->_observer = observer;
        info->_md5Str = kvo_md5StringOfObject(observer);
        info->_keyPath = keyPath;
        info->_options = options;
        info->_context = context;
        [kvoInfos addObject:info];
        [self setKVOInfos:kvoInfos ForKeypath:keyPath];
        if (success) {
            success();
        }
    }
    [_bmp_kvoLock unlock];
}

- (BOOL)removeKVOInfoInMapsWithObserver:(NSObject *)observer
                             forKeyPath:(NSString *)keyPath{
    [_bmp_kvoLock lock];
    BOOL success;
    NSMutableArray <KVOInfo *> *kvoInfos = [self getKVOInfosForKeypath:keyPath];
    __block BOOL isExist = NO;
    __block KVOInfo *kvoInfo;
    [kvoInfos enumerateObjectsUsingBlock:^(KVOInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj->_md5Str isEqualToString:kvo_md5StringOfObject(observer)]) {
            isExist = YES;
            kvoInfo = obj;
        }
    }];
    if (kvoInfo) {
        [kvoInfos removeObject:kvoInfo];
        if (kvoInfos.count == 0) {//说明该keypath没有observer观察，可以移除该键
            [_keyPathMaps removeObjectForKey:keyPath];
        }
    }
    success = isExist;
    [_bmp_kvoLock unlock];
    return success;
}

#pragma mark 获取keypath对应的所有观察者
- (NSMutableArray *)getKVOInfosForKeypath:(NSString *)keypath{
    if ([_keyPathMaps.allKeys containsObject:keypath]) {
        return [_keyPathMaps objectForKey:keypath];
    }else{
        return [NSMutableArray array];
    }
}

#pragma mark  设置keypath对应的观察者数组
- (void)setKVOInfos:(NSMutableArray *)kvoInfos ForKeypath:(NSString *)keypath{
    if (![_keyPathMaps.allKeys containsObject:keypath]) {
        if (keypath) {
            _keyPathMaps[keypath] = kvoInfos;
        }
    }
}

#pragma mark 实际观察者执行相对应的监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSMutableArray <KVOInfo *> *kvoInfos = [self getKVOInfosForKeypath:keyPath];
    for (NSObject *observer in kvoInfos) {
        @try {
            [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        } @catch (NSException *exception) {
            NSString *reason = [NSString stringWithFormat:@"non fatal Error%@",[exception description]];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
        }
    }
}

#pragma mark 获取所有被观察的keypaths
- (NSArray *)getAllKeypaths{
    NSArray <NSString *>*keyPaths = _keyPathMaps.allKeys;
    return keyPaths;
}


@end

@implementation NSObject (SafeKVO)

static void *KVOProtectorKey = &KVOProtectorKey;
static NSString *const KVOProtectorValue = @"BMP_KVOProtector";
static void *BayMaxKVODelegateKey = &BayMaxKVODelegateKey;


+ (void)registerClassPairMethodsInKVO {
    
    [self instanceSwizzleMethod:@selector(addObserver:forKeyPath:options:context:) replaceMethod:@selector(BMP_addObserver:forKeyPath:options:context:)];
    
    [self instanceSwizzleMethod:@selector(removeObserver:forKeyPath:) replaceMethod:@selector(BMP_removeObserver:forKeyPath:)];
    
    [self instanceSwizzleMethod:@selector(removeObserver:forKeyPath:) replaceMethod:@selector(BMP_removeObserver:forKeyPath:context:)];
    
     [self instanceSwizzleMethod:NSSelectorFromString(@"dealloc") replaceMethod:@selector(BMPKVO_dealloc)];
}

- (void)BMP_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    if (!isSystemClass(self.class)) {
        __weak typeof(self) weakSelf = self;
        objc_setAssociatedObject(self, KVOProtectorKey, KVOProtectorValue, OBJC_ASSOCIATION_RETAIN);
        [self.kvoProxy addKVOInfoToMapsWithObserver:observer forKeyPath:keyPath options:options context:context success:^{
            [weakSelf BMP_addObserver:weakSelf.kvoProxy forKeyPath:keyPath options:options context:context];
        } failure:^(NSError *error) {
            NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
           
        }];
    }else{
        [self BMP_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)BMP_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    if (!isSystemClass(self.class)) {
        if ([self.kvoProxy removeKVOInfoInMapsWithObserver:observer forKeyPath:keyPath]) {
            [self BMP_removeObserver:self.kvoProxy forKeyPath:keyPath];
        }else{
            NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
            NSString *reson = [NSString stringWithFormat:@"Cannot remove an observer %@ for the key path '%@' from %@ because it is not registered as an observer",observer,keyPath,NSStringFromClass(self.class) == nil?@"":NSStringFromClass(self.class)];
            
        }
    }else{
        [self BMP_removeObserver:observer forKeyPath:keyPath];
    }
}

- (void)BMP_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context{
    if (!isSystemClass(self.class)) {
        if ([self.kvoProxy removeKVOInfoInMapsWithObserver:observer forKeyPath:keyPath]) {
            [self BMP_removeObserver:self.kvoProxy forKeyPath:keyPath];
        }else{
            NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
            NSString *reson = [NSString stringWithFormat:@"Cannot remove an observer %@ for the key path '%@' from %@ because it is not registered as an observer",observer,keyPath,NSStringFromClass(self.class) == nil?@"":NSStringFromClass(self.class)];
            
        }
    }else{
        [self BMP_removeObserver:observer forKeyPath:keyPath context:context];
    }
}

- (void)BMPKVO_dealloc{
    if (!isSystemClass(self.class)) {
        NSString *value = (NSString *)objc_getAssociatedObject(self, KVOProtectorKey);
        if ([value isEqualToString:KVOProtectorValue]) {
            NSArray *keypaths = [self.kvoProxy getAllKeypaths];
            if (keypaths.count>0) {
                NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
                NSString *reson = [NSString stringWithFormat:@"An instance %@ was deallocated while key value observers were still registered with it. The Keypaths is:'%@'",self,[keypaths componentsJoinedByString:@","]];
               
            }
            [keypaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL * _Nonnull stop) {
                //错误信息
                [self BMP_removeObserver:self.kvoProxy forKeyPath:keyPath];
            }];
        }
    }
    [self BMPKVO_dealloc];
}

- (void)setKvoProxy:(XXKVOProxy *)kvoProxy {
    objc_setAssociatedObject(self, @selector(kvoProxy), kvoProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XXKVOProxy *)kvoProxy {
    XXKVOProxy *getKvoProxy = objc_getAssociatedObject(self, @selector(kvoProxy));
    if (!getKvoProxy) {
        getKvoProxy = [[XXKVOProxy alloc] init];
        objc_setAssociatedObject(self, @selector(kvoProxy), getKvoProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return getKvoProxy;
}

@end
