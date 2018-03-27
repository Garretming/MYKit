//
//  UIImage+Extension.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/**
*  @brief 根据URL生成图片
*
*  @param imageURL 图片URL
*
*  @return 返回处理后的图片
*/
+ (nullable UIImage *)imageWithURL:(NSURL *)imageURL;

/**
 *  @brief 设置图片的透明度
 *
 *  @param alpha 透明度
 *
 *  @return 返回处理后的图片
 */
- (nullable UIImage *)imageWithAlpha:(CGFloat)alpha;

/**
 Returns a new image which is scaled from this image.
 The image will be stretched as needed.
 
 @param size  The new size to be scaled, values should be positive.
 
 @return      The new image with the given size.
 */
- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

/**
 *  @brief 根据name获取GIF图片
 *
 *  @param name 图片名称
 *
 *  @return 返回处理后的图片
 */
+ (nullable UIImage *)animatedGIFNamed:(NSString *)name;

/**
 *  @brief 根据data获取GIF图片
 *
 *  @param data 图片数据流
 *
 *  @return 返回处理后的图片
 */
+ (nullable UIImage *)animatedGIFWithData:(NSData *)data;

- (nullable UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END

