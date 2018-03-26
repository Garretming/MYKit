//
//  _UIAlertController+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertControllerDelegate <NSObject>

- (void)addButtonWithTitle:(NSString *)inLabel block:(void(^)(void))block;
- (void)setCancelButtonWithTitle:(NSString *)inLabel block:(void(^)(void))block;
- (void)setDestructiveButtonWithTitle:(NSString *)inLabel block:(void(^)(void))block;
- (void)showInController:(UIViewController *)controller;

@end

@interface UIAlertController (Addition)

@end
