//
//  UIApplication+SafeKit.h
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (SafeKit)

/**
 *  是否是测试环境
 */
@property (nonatomic, assign, readwrite) BOOL safeKit_isTestEnvironment;


@end
