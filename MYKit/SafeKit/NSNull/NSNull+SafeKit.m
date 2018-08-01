//
//  NSNull+SafeKit.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/21.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSNull+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "MYSafeKitRecord.h"

@implementation NSNull (SafeKit)

+ (void)safeGuardNullSelector {
    
    // 防御对象实例方法
    [self instanceSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(safe_forwardingTargetForSelector:)];
}

- (id)safe_forwardingTargetForSelector:(SEL)aSelector {
    
    static NSArray *sTmpOutput = nil;
    if (sTmpOutput == nil) {
        sTmpOutput = @[@"", @0, @[], @{}];
    }
    
    for (id tmpObj in sTmpOutput) {
        if ([tmpObj respondsToSelector:aSelector]) {
            NSString *reason = [NSString stringWithFormat:@"*****Warning***** logic error.target is %@ method is %@, reason : method forword to SmartFunction Object default implement like send message to nil.",[self class], NSStringFromSelector(aSelector)];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeNSNull)];
            return tmpObj;
        }
    }
    return [self safe_forwardingTargetForSelector:aSelector];
}

@end
