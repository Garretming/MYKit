//
//  UIAlertView+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_UIAlertController+Addition.h"

@interface UIAlertView (Addition) <UIAlertViewDelegate, CustomAlertControllerDelegate>

@property (nonatomic, copy) NSDictionary *userInfo;

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message;

@end
