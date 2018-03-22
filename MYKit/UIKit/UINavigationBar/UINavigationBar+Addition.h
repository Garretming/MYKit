//
//  UINavigationBar+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/22.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Addition)

/**
 设置导航栏所有BarButtonItem的透明度
 */
- (void)setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

@end
