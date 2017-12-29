//
//  UIButton+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Addition)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

+ (UIButton *)buttonWithBackgoundImageName:(NSString *)backgroundImageName;

+ (UIButton *)buttonWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
