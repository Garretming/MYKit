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

+ (nullable UIImage *)imageNoCacheWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END

