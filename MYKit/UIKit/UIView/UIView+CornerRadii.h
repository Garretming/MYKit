//
//  UIView+CornerRadii.h
//  LPDCrowdsource
//
//  Created by eMr.Wang on 16/1/29.
//  Copyright © 2016年 elm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 *  设置 viewRectCornerType 样式，
 *  注意：MYRectCornerType 必须要先设置 viewCornerRadius，才能有效，否则设置无效，
 */
typedef NS_ENUM(NSInteger, MYRectCornerType) {
    /*!
     *  设置下左角 圆角半径
     */
    MYRectCornerTypeBottomLeft = 0,
    /*!
     *  设置下右角 圆角半径
     */
    MYRectCornerTypeBottomRight,
    /*!
     *  设置上左角 圆角半径
     */
    MYRectCornerTypeTopLeft,
    /*!
     *  设置下右角 圆角半径
     */
    MYRectCornerTypeTopRight,
    /*!
     *  设置下左、下右角 圆角半径
     */
    MYRectCornerTypeBottomLeftAndBottomRight,
    /*!
     *  设置上左、上右角 圆角半径
     */
    MYRectCornerTypeTopLeftAndTopRight,
    /*!
     *  设置下左、上左角 圆角半径
     */
    MYRectCornerTypeBottomLeftAndTopLeft,
    /*!
     *  设置下右、上右角 圆角半径
     */
    MYRectCornerTypeBottomRightAndTopRight,
    /*!
     *  设置上左、上右、下右角 圆角半径
     */
    MYRectCornerTypeBottomRightAndTopRightAndTopLeft,
    /*!
     *  设置下右、上右、下左角 圆角半径
     */
    MYRectCornerTypeBottomRightAndTopRightAndBottomLeft,
    /*!
     *  设置全部四个角 圆角半径
     */
    MYRectCornerTypeAllCorners
};

@interface UIView (CornerRadii)

// 指定倒角
- (void)setCornerRadii:(CGFloat)cornerRadii roundingCorners:(UIRectCorner)roundingCorners;

/**
 快速切圆角
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 */
- (void)setViewRectCornerType:(MYRectCornerType)type
                     viewCornerRadius:(CGFloat)viewCornerRadius;

/**
 快速切圆角，带边框、边框颜色
 
 @param type 圆角样式
 @param viewCornerRadius 圆角角度
 @param borderWidth 边线宽度
 @param borderColor 边线颜色
 */
- (void)setViewRectCornerType:(MYRectCornerType)type
                     viewCornerRadius:(CGFloat)viewCornerRadius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
