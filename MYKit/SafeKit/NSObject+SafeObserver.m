//
//  NSObject+SafeObserver.m
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSObject+SafeObserver.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"

@implementation NSObject (SafeObserver)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_removeObserver:forKeyPath:) tarSel:@selector(removeObserver:forKeyPath:)];
    });
}

- (void)safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    @try {
        [self safe_removeObserver:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {
        [self sf_showRemoveMoreObserver];
    }
}

@end
