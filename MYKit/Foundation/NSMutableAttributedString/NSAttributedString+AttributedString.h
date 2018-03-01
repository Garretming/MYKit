//
//  NSAttributedString+AttributedString.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/1.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (AttributedString)

/**
 根据富文本的宽度返回文字的高度
 
 @param width 宽度
 @return CGFloat
 */
- (CGFloat)attributedStringHeightWithContainWidth:(CGFloat)width;

/**
 修改指定Range字符串的颜色
 
 @param string 字符串
 @param color 颜色
 @param range NSRange
 @return NSAttributedString
 */
+ (NSAttributedString *)attributeStringWithString:(NSString *)string
                                            color:(UIColor *)color
                                            range:(NSRange)range;

/**
 修改指定Range字符串的颜色
 
 @param attributedString attributedString字符串
 @param color 颜色
 @param range NSRange
 @return NSAttributedString
 */
+ (NSAttributedString *)attributeStringWithAttributedString:(NSAttributedString *)attributedString
                                                      color:(UIColor *)color
                                                      range:(NSRange)range;
/**
 修改指定Range字符串的字体
 
 @param string 字符串
 @param font 字体
 @param range NSRange
 @return NSAttributedString
 */
+ (NSAttributedString *)attributeStringWithString:(NSString *)string
                                             font:(UIFont *)font
                                            range:(NSRange)range;

/**
 修改指定Range字符串的字体
 
 @param attributedString attributedString字符串
 @param font 字体
 @param range NSRange
 @return NSAttributedString
 */
+ (NSAttributedString *)attributeStringWithAttributedString:(NSAttributedString *)attributedString
                                                       font:(UIFont *)font
                                                      range:(NSRange)range;
/**
 返回设置好的NSAttributedString
 
 @param prefixString 前缀String
 @param prefixFont   前缀字体大小
 @param suffixString 尾缀String
 @param suffixFont   尾缀字体大小
 @return NSAttributedString
 */
+ (NSAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString
                                             prefixFont:(UIFont *)prefixFont
                                           suffixString:(NSString *)suffixString
                                             suffixFont:(UIFont *)suffixFont;
/**
 返回设置好的NSAttributedString
 
 @param prefixString 前缀String
 @param prefixFont   前缀字体大小
 @param prefixColor  前缀字体颜色
 @param suffixString 尾缀String
 @param suffixFont   尾缀字体大小
 @param suffixColor  尾缀字体颜色
 @return NSAttributedString
 */
+ (NSAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString
                                             prefixFont:(UIFont *)prefixFont
                                            prefixColor:(UIColor *)prefixColor
                                           suffixString:(NSString *)suffixString
                                             suffixFont:(UIFont *)suffixFont
                                            suffixColor:(UIColor *)suffixColor;


@end
