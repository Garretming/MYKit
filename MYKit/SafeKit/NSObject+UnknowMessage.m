//
//  NSObject+Message.m
//  A
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSObject+UnknowMessage.h"
#import "MessageTrash.h"
#import "NSObject+Swizzle.h"

@implementation NSObject (UnknowMessage)

+ (void)safeGuardUnrecognizedSelector {
    
    [self safe_swizzleMethod:@selector(exchange_forwardingTargetForSelector:) tarClass:NSStringFromClass([self class]) tarSel:@selector(forwardingTargetForSelector:)];
}

- (id)exchange_forwardingTargetForSelector:(SEL)aSelector {
    NSMethodSignature * signature = [self methodSignatureForSelector:aSelector];
    if ([self respondsToSelector:aSelector] || signature) {
        return [self exchange_forwardingTargetForSelector:aSelector];
    }
    return [MessageTrash source:[self class] selector:aSelector];
}

@end
