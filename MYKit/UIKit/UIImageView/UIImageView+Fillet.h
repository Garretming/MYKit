//
//  UIImageView+Fillet.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Fillet)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)cornerRadiusRoundingRect;

- (void)attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
