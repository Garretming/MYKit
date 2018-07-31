//
//  NSObject+UnknowSelector.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/19.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSObject+UnknowSelector.h"
#import "NSObject+Swizzle.h"
#import "MYSafeKitRecord.h"
#import <dlfcn.h>

/**
 default Implement
 
 @param target trarget
 @param cmd cmd
 @param ... other param
 @return default Implement is zero
 */
int smartFunction(id target, SEL cmd, ...) {
    return 0;
}

static BOOL __addMethod(Class clazz, SEL sel) {
    NSString *selName = NSStringFromSelector(sel);
    
    NSMutableString *tmpString = [[NSMutableString alloc] initWithFormat:@"%@", selName];
    
    int count = (int)[tmpString replaceOccurrencesOfString:@":"
                                                withString:@"_"
                                                   options:NSCaseInsensitiveSearch
                                                     range:NSMakeRange(0, selName.length)];
    
    NSMutableString *val = [[NSMutableString alloc] initWithString:@"i@:"];
    
    for (int i = 0; i < count; i++) {
        [val appendString:@"@"];
    }
    const char *funcTypeEncoding = [val UTF8String];
    return class_addMethod(clazz, sel, (IMP)smartFunction, funcTypeEncoding);
}

@interface MYShieldStubObject : NSObject

- (instancetype)init __unavailable;

+ (MYShieldStubObject *)shareInstance;

- (BOOL)addFunc:(SEL)sel;

+ (BOOL)addClassFunc:(SEL)sel;

@end

@implementation MYShieldStubObject

+ (MYShieldStubObject *)shareInstance {
    static MYShieldStubObject *singleton;
    if (!singleton) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singleton = [MYShieldStubObject new];
        });
    }
    return singleton;
}

- (BOOL)addFunc:(SEL)sel {
    return __addMethod([MYShieldStubObject class], sel);
}

+ (BOOL)addClassFunc:(SEL)sel {
    Class metaClass = objc_getMetaClass(class_getName([MYShieldStubObject class]));
    return __addMethod(metaClass, sel);
}

@end

@implementation NSObject (UnknowSelector)

+ (void)safeGuardUnrecognizedSelector {
    
    // 防御对象实例方法
    [self instanceSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(exchange_instanceMethod_forwardingTargetForSelector:)];
    
    // 防御对象类方法
    [self swizzleClassMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(exchange_classMethod_forwardingTargetForSelector:)];
}

- (id)exchange_instanceMethod_forwardingTargetForSelector:(SEL)aSelector {
    
    static struct dl_info app_info;
    if (app_info.dli_saddr == NULL) {
        dladdr((__bridge void *)[UIApplication.sharedApplication.delegate class], &app_info);
    }
    struct dl_info self_info = {0};
    dladdr((__bridge void *)[self class], &self_info);
    
    //    ignore system class
    if (self_info.dli_fname == NULL || strcmp(app_info.dli_fname, self_info.dli_fname)) {
        return [self exchange_instanceMethod_forwardingTargetForSelector:aSelector];
    }
    
    // 1 如果是NSSNumber 和NSString没找到就是类型不对  切换下类型就好了
    if ([self isKindOfClass:[NSNumber class]] && [NSString instancesRespondToSelector:aSelector]) {
        NSNumber *number = (NSNumber *)self;
        NSString *str = [number stringValue];
        return str;
    } else if ([self isKindOfClass:[NSString class]] && [NSNumber instancesRespondToSelector:aSelector]) {
        NSString *str = (NSString *)self;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [formatter numberFromString:str];
        return number;
    }
    
    BOOL aBool = [self respondsToSelector:aSelector];
    
    NSMethodSignature * signature = [self methodSignatureForSelector:aSelector];
    if (aBool || signature) {
        return [self exchange_instanceMethod_forwardingTargetForSelector:aSelector];
    } else {
        MYShieldStubObject *stub = [MYShieldStubObject shareInstance];
        [stub addFunc:aSelector];
        
        NSString *reason = [NSString stringWithFormat:@"*****Warning***** logic error.target is %@ method is %@, reason : method forword to Object default implement like send message to nil.",[self class], NSStringFromSelector(aSelector)];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeUnrecognizedSelector)];
        return stub;
    }
}

+ (id)exchange_classMethod_forwardingTargetForSelector:(SEL)aSelector {
    
    // 1 如果是NSSNumber 和NSString没找到就是类型不对  切换下类型就好了
    if ([self isKindOfClass:[NSNumber class]] && [NSString instancesRespondToSelector:aSelector]) {
        NSNumber *number = (NSNumber *)self;
        NSString *str = [number stringValue];
        return str;
    } else if ([self isKindOfClass:[NSString class]] && [NSNumber instancesRespondToSelector:aSelector]) {
        NSString *str = (NSString *)self;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [formatter numberFromString:str];
        return number;
    }
    
    BOOL aBool = [self respondsToSelector:aSelector];
    
    NSMethodSignature * signature = [self methodSignatureForSelector:aSelector];
    if (aBool || signature) {
        return [self exchange_classMethod_forwardingTargetForSelector:aSelector];
    } else {
        MYShieldStubObject *stub = [MYShieldStubObject shareInstance];
        [stub addFunc:aSelector];
        
        NSString *reason = [NSString stringWithFormat:@"*****Warning***** logic error.target is %@ method is %@, reason : method forword to Object default implement like send message to nil.",[self class], NSStringFromSelector(aSelector)];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeUnrecognizedSelector)];
        return stub;
    }
}

@end
