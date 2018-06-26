//
//  MYSafeKit.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/26.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYSafeKit.h"
#import "NSNull+SafeKit.h"
#import "MYSafeFoundationContainer.h"
#import "NSObject+UnknowSelector.h"

@implementation MYSafeKit

+ (void)registerSafeKitShield {
    [self registerSafeKitShieldWithAbility:(MYSafeKitShieldTypeAll)];
}

+ (void)registerSafeKitShieldWithAbility:(MYSafeKitShieldType)ability {
    if (ability & MYSafeKitShieldTypeUnrecognizedSelector) {
        [self registerUnrecognizedSelector];
    }
    if (ability & MYSafeKitShieldTypeContainer) {
        [self registerContainer];
    }
    if (ability & MYSafeKitShieldTypeNSNull) {
        [self registerNSNull];
    }
    if (ability & MYSafeKitShieldTypeKVO) {
        [self registerKVO];
    }
    if (ability & MYSafeKitShieldTypeNotification) {
        [self registerNotification];
    }
    if (ability & MYSafeKitShieldTypeTimer) {
        [self registerTimer];
    }
}

+ (void)registerNSNull {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNull safeGuardNullSelector];
    });
}

+ (void)registerContainer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MYSafeFoundationContainer safeGuardContainersSelector];
    });
}

+ (void)registerUnrecognizedSelector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject safeGuardUnrecognizedSelector];
    });
}

+ (void)registerKVO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

+ (void)registerNotification {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

+ (void)registerTimer {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

+ (void)registerDanglingPointer:(NSArray *)arr {
    NSMutableArray *avaibleList = arr.mutableCopy;
    for (NSString *className in arr) {
        NSBundle *classBundle = [NSBundle bundleForClass:NSClassFromString(className)];
        if (classBundle != [NSBundle mainBundle]) {
            [avaibleList removeObject:className];
        }
    }
}


@end
