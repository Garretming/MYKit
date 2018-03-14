//
//  UIColor+Hex.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 Creates and returns a color object from hex string.
 
 @discussion:
 Valid format: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 The `#` or "0x" sign is not required.
 The alpha will be set to 1.0 if there is no alpha component.
 It will return nil when an error occurs in parsing.
 
 Example: @"0xF0F", @"66ccff", @"#66CCFF88"
 
 @param hexStr  The hex string value for the new color.
 
 @return        An UIColor object from string, or nil if an error occurs.
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alphaValue;

/**
 十六进制转UIColor
 
 @param hexValue 十六进制颜色值
 @return UIColor
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue;

/**
 十六进制转UIColor
 
 @param hexValue 十六进制颜色值
 @param alphaValue 透明度
 @return 返回十六进制转成的UIColor
 */
+ (UIColor *)colorWithHex:(NSInteger)hexValue
                    alpha:(CGFloat)alphaValue;


@end
