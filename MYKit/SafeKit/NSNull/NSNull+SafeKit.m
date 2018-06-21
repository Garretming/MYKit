//
//  NSNull+SafeKit.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/21.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSNull+SafeKit.h"
#import "NSObject+Swizzle.h"

@implementation NSNull (SafeKit)

+ (void)safeGuardNullSelector {
    
    // 防御对象实例方法
    [self instanceSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(exchange_instanceMethod_forwardingTargetForSelector:)];
}

- (id)exchange_instanceMethod_forwardingTargetForSelector:(SEL)aSelector {
    
    static NSArray *sTmpOutput = nil;
    if (sTmpOutput == nil) {
        sTmpOutput = @[@"", @0, @[], @{}];
    }
    
    for (id tmpObj in sTmpOutput) {
        if ([tmpObj respondsToSelector:aSelector]) {
            NSLog(@"*****Warning***** logic error.target is %@ method is %@, reason : method forword to SmartFunction Object default implement like send message to nil.",
                  [self class], NSStringFromSelector(aSelector));
            return tmpObj;
        }
    }
    return [self exchange_instanceMethod_forwardingTargetForSelector:aSelector];
}

@end
