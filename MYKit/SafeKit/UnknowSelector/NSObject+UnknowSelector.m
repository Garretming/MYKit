//
//  NSObject+UnknowSelector.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/19.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSObject+UnknowSelector.h"
#import "NSObject+Swizzle.h"
#import "MYShieldStubObject.h"

@implementation NSObject (UnknowSelector)

+ (void)safeGuardUnrecognizedSelector {
    
    // 防御对象实例方法
    [self instanceSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(exchange_instanceMethod_forwardingTargetForSelector:)];
    
    // 防御对象类方法
    [self swizzleClassMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(exchange_classMethod_forwardingTargetForSelector:)];
}

- (id)exchange_instanceMethod_forwardingTargetForSelector:(SEL)aSelector {
    
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
        
        NSLog(@"*****Warning***** logic error.target is %@ method is %@, reason : method forword to SmartFunction Object default implement like send message to nil.",
              [self class], NSStringFromSelector(aSelector));
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
        
        NSLog(@"*****Warning***** logic error.target is %@ method is %@, reason : method forword to SmartFunction Object default implement like send message to nil.",
              [self class], NSStringFromSelector(aSelector));
        return stub;
    }
}

@end
