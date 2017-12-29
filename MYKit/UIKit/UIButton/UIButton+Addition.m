//
//  UIButton+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIButton+Addition.h"
#import "UIColor+Hex.h"
#import "UIImage+Color.h"
#import "UIImage+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIButton (Addition)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    UIImage *backgroundImage = [UIImage imageWithColor:color];
    self.clipsToBounds = YES;
    [self setBackgroundImage:backgroundImage forState:state];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName {
    return [self buttonWithImageName:imageName isBackgroundImage:NO];
}

+ (UIButton *)buttonWithBackgoundImageName:(NSString *)backgroundImageName {
    return [self buttonWithImageName:backgroundImageName isBackgroundImage:YES];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName isBackgroundImage:(BOOL)isBackground {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNoCacheWithName:imageName];
    UIImage *highlightedImage = [UIImage imageNoCacheWithName:[NSString stringWithFormat:@"%@_selected", imageName]];
    highlightedImage = highlightedImage ?: [UIImage opacityImage:image opacity:0.5f];
    UIImage *disabledImage = [UIImage imageNoCacheWithName:[NSString stringWithFormat:@"%@_disabled", imageName]];
    disabledImage = disabledImage ?: [UIImage maskImage:image withColor:[UIColor colorWithHexString:@"#666666"]];
    if (isBackground) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:highlightedImage forState:UIControlStateSelected];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    } else {
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:highlightedImage forState:UIControlStateSelected];
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
        [button setImage:disabledImage forState:UIControlStateDisabled];
    }
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    return button;
}

@end

NS_ASSUME_NONNULL_END
