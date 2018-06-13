//
//  UIApplication+SafeKit.m
//  QMSafeKit
//
//  Created by David on 2018/3/30.
//  Copyright © 2018年 David. All rights reserved.
//

#import "UIApplication+SafeKit.h"
#import <objc/runtime.h>

@implementation UIApplication (SafeKit)

- (BOOL)safeKit_isTestEnvironment {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setSafeKit_isTestEnvironment:(BOOL)safeKit_isTestEnvironment {
    objc_setAssociatedObject(self, @selector(safeKit_isTestEnvironment), @(safeKit_isTestEnvironment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
