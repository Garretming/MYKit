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
 *  @brief  以传入的视图为源，根据主窗口压缩比例截图
 *
 *  @param sourceView 源视图
 *
 *  @return 如果源视图为nil，则返回nil
 */
+ (UIImage *)captureWithView:(UIView *)sourceView;

/**
 *  @brief  从原来图片截取图片
 *
 *  @param imageRect 尺寸
 *
 *  @return 图片
 */
+ (UIImage *)captureImageWithRect:(CGRect)imageRect originalImage:(UIImage *)originalImage;

/**
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param view    指定的view
 *  @param maxWidth 宽的大小 0为view默认大小
 *
 *  @return 截图
 */
+ (UIImage *)screenshotWithView:(UIView *)view limitWidth:(CGFloat)maxWidth;

/**
 Returns a new image which is cropped from this image.
 
 @param rect  Image's inner rect.
 
 @return      The new image, or nil if an error occurs.
 */
- (nullable UIImage *)imageByCropToRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
