//
//  NSString+Attributed.m
//  Zhibo
//
//  Created by 孙金帅 on 2016/10/26.
//  Copyright © 2016年 孙金帅. All rights reserved.
//

#import "NSString+Attributed.h"

@implementation NSString (Attributed)

/**
 给 button 添加下划线
 
 @param button button
 @param range button 的 title 需要加下划线的地方
 @param lineColor 下划线颜色
 */
+ (void)stringUnderlineWithButton:(UIButton *)button
                      range:(NSRange)range
                  lineColor:(UIColor *)lineColor
{
    [self stringUnderlineWithButton:button range:range lineColor:lineColor controlstate:UIControlStateNormal];
}

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
               controlstate:(UIControlState)controlstate
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
    [str addAttribute:NSUnderlineColorAttributeName value:lineColor range:range];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [button setAttributedTitle:str forState:controlstate];
}

/**
 给 label 添加下划线
 
 @param label label
 @param range label 的 title 需要加下划线的地方
 @param lineColor 下划线颜色
 */
+ (void)stringUnderlineWithLabel:(UILabel *)label
                           range:(NSRange)range
                       lineColor:(UIColor *)lineColor {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSUnderlineColorAttributeName value:lineColor range:range];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    [label setAttributedText:str];
}

@end
