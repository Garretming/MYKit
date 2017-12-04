//
//  NSString+Attributed.h
//  Zhibo
//
//  Created by 孙金帅 on 2016/10/26.
//  Copyright © 2016年 孙金帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Attributed)

+ (NSAttributedString *)stringWitParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle
                                          title:(NSString *)title
                                          image:(UIImage *)image;

/**
 给 button 添加下划线
 
 @param button button
 @param range button 的 title 需要加下划线的地方
 @param lineColor 下划线颜色
 */
+ (void)stringUnderlineWithButton:(UIButton *)button
                            range:(NSRange)range
                        lineColor:(UIColor *)lineColor;

/**
 给 button 添加下划线
 
 @param button button
 @param range button 的 title 需要加下划线的地方
 @param lineColor 下划线颜色
 @param controlstate UIControlState
 */
+ (void)stringUnderlineWithButton:(UIButton *)button
                            range:(NSRange)range
                        lineColor:(UIColor *)lineColor
                     controlstate:(UIControlState)controlstate;

/**
 给 label 添加下划线
 
 @param label label
 @param range label 的 title 需要加下划线的地方
 @param lineColor 下划线颜色
 */
+ (void)stringUnderlineWithLabel:(UILabel *)label
                           range:(NSRange)range
                       lineColor:(UIColor *)lineColor;

@end
