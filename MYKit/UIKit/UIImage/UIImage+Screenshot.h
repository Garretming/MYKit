//
//  UIImage+Screenshot.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Screenshot)

/**
 *  @brief  根据颜色生成图片，默认size为{1.f, 1.f}
 *  @param color 传入颜色
 *  @return 返回图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  @brief 设置图片的透明度
 *  @param alpha 透明度
 *  @return 返回处理后的图片
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

/**
 *  @brief 设置图片的size
 *  @return 返回改变size之后的图片
 */
- (UIImage *)resizeTo:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
