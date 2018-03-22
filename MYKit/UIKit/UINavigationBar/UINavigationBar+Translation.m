//
//  UINavigationBar+Translation.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UINavigationBar+Translation.h"

@implementation UINavigationBar (Translation)

/// 设置导航栏在垂直方向上平移多少距离 CGAffineTransformMakeTranslation 平移
- (void)setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)getTranslationY {
    return self.transform.ty;
}

@end
