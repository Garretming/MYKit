//
//  NSTimer+Safe.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/30.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSTimer+Safe.h"
#import "MYSafeKitRecord.h"
#import "NSObject+Swizzle.h"

@interface XXTimerProxy : NSObject

@property (nonatomic, weak) NSTimer *sourceTimer;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL aSelector;

@end

@implementation XXTimerProxy

- (void)trigger:(id)userinfo {
    id strongTarget = self.target;
    if (strongTarget && ([strongTarget respondsToSelector:self.aSelector])) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [strongTarget performSelector:self.aSelector withObject:userinfo];
#pragma clang diagnostic pop
    } else {
        NSTimer *sourceTimer = self.sourceTimer;
        if (sourceTimer) {
            [sourceTimer invalidate];
        }
        NSString *reason = [NSString stringWithFormat:@"*****Warning***** logic error target is %@ method is %@, reason : an object dealloc not invalidate Timer.",[self class], NSStringFromSelector(self.aSelector)];
        
        [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeTimer)];
    }
}

@end

@implementation NSTimer (Safe)

+ (void)registerClassPairMethodsInTimer {
    
    [self swizzleClassMethod:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) replaceMethod:@selector(safe_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
}

+ (NSTimer *)safe_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    if (yesOrNo) {
        NSTimer *timer = nil;
        @autoreleasepool {
            XXTimerProxy *proxy = [XXTimerProxy new];
            proxy.target = aTarget;
            proxy.aSelector = aSelector;
            timer.timerProxy = proxy;
            timer = [self safe_scheduledTimerWithTimeInterval:ti target:proxy selector:@selector(trigger:) userInfo:userInfo repeats:yesOrNo];
            proxy.sourceTimer = timer;
        }
        return timer;
    }
    return [self safe_scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

- (void)setTimerProxy:(XXTimerProxy *)timerProxy {
    objc_setAssociatedObject(self, @selector(timerProxy), timerProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XXTimerProxy *)timerProxy {
    return objc_getAssociatedObject(self, @selector(timerProxy));
}

@end
