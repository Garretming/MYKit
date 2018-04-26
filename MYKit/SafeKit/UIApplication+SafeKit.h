//
//  UIApplication+SafeKit.h
//  QMSafeKit
//
//  Created by David on 2018/3/30.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SafeKit)

/**
 *  是否是测试环境
 */
@property (nonatomic, assign, readwrite) BOOL safeKit_isTestEnvironment;


@end
