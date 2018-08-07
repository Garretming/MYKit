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

/**
 {keypath : [ob1,ob2]}
 */
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

@interface XXKVOProxy : NSObject {
    __unsafe_unretained NSObject *_observed;
}

/**
 {keypath : [ob1,ob2]}
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSHashTable<NSObject *> *> *kvoInfoMap;

@end

@implementation XXKVOProxy

- (instancetype)initWithObserverd:(NSObject *)observed {
    if (self = [super init]) {
        _observed = observed;
    }
    return self;
}

- (void)dealloc {
    @autoreleasepool {
        NSDictionary<NSString *, NSHashTable<NSObject *> *> *kvoinfos =  self.kvoInfoMap.copy;
        for (NSString *keyPath in kvoinfos) {
            [self removeObserver:_observed forKeyPath:keyPath];
        }
    }
}

- (NSMutableDictionary<NSString *, NSHashTable<NSObject *> *> *)kvoInfoMap {
    if (!_kvoInfoMap) {
        _kvoInfoMap = @{}.mutableCopy;
    }
    return _kvoInfoMap;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // dispatch to origina observers
    NSHashTable<NSObject *> *os = self.kvoInfoMap[keyPath];
    for (NSObject *observer in os) {
        @try {
            [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        } @catch (NSException *exception) {
            NSString *reason = [NSString stringWithFormat:@"non fatal Error%@",[exception description]];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
        }
    }
}

@end

@implementation NSObject (SafeKVO)

+ (void)registerClassPairMethodsInKVO {
    
    [self instanceSwizzleMethod:@selector(addObserver:forKeyPath:options:context:) replaceMethod:@selector(safe_addObserver:forKeyPath:options:context:)];
    
    [self instanceSwizzleMethod:@selector(removeObserver:forKeyPath:) replaceMethod:@selector(safe_removeObserver:forKeyPath:)];
    
//     [self instanceSwizzleMethod:NSSelectorFromString(@"dealloc") replaceMethod:@selector(safe_dealloc)];
}

- (void)safe_dealloc {
    if (!isSystemClass(self.class)) {
//        NSLog(@"%@",self.kvoProxy.kvoInfoMap);
    }
    [self safe_dealloc];
}

- (void)safe_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    if (!isSystemClass(self.class)) {
        if (!self.kvoProxy) {
            @autoreleasepool {
                self.kvoProxy = [[XXKVOProxy alloc] initWithObserverd:self];
            }
        }
        
        NSHashTable<NSObject *> *os = self.kvoProxy.kvoInfoMap[keyPath];
        if (os.count == 0) {
            os = [[NSHashTable alloc] initWithOptions:(NSPointerFunctionsWeakMemory) capacity:0];
            [os addObject:observer];
            
            [self safe_addObserver:self.kvoProxy forKeyPath:keyPath options:options context:context];
            self.kvoProxy.kvoInfoMap[keyPath] = os;
            
            return ;
        }
        
        if ([os containsObject:observer]) {
            NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@, reason : KVO add Observer to many timers.",
                                [self class], NSStringFromSelector(_cmd)];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
        } else {
            [os addObject:observer];
            [self safe_addObserver:self.kvoProxy forKeyPath:keyPath options:options context:context];
            // 更新kvoInfoMaps
            self.kvoProxy.kvoInfoMap[keyPath] = os;
        }
    } else {
        [self safe_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    if (!isSystemClass(self.class)) {
        NSHashTable<NSObject *> *os = self.kvoProxy.kvoInfoMap[keyPath];
        
        if (os.count == 0) {
            NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@, reason : KVO remove Observer to many times.",
                                [self class], NSStringFromSelector(_cmd)];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
            return ;
        }
        [os removeObject:observer];
        if (os.count == 0) {
            [self safe_removeObserver:self.kvoProxy forKeyPath:keyPath];
            [self.kvoProxy.kvoInfoMap removeObjectForKey:keyPath];
        }
    } else {
        [self safe_removeObserver:observer forKeyPath:keyPath];
    }
}

- (void)setKvoProxy:(XXKVOProxy *)kvoProxy {
    objc_setAssociatedObject(self, @selector(kvoProxy), kvoProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XXKVOProxy *)kvoProxy {
    return objc_getAssociatedObject(self, @selector(kvoProxy));
}

@end
