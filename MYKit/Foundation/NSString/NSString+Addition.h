//
//  NSString+Addition.h
//  FXKitExample
//
//  Created by sunjinshuai on 2017/7/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Addition)

/**
 *  @brief 获取字符数量
 */
- (int)wordsCount;

/**
 判断URL中是否包含中文
 */
- (BOOL)isContainChinese;

/**
 判断字符串是否为空
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
 字典转换字符串
 */
+ (NSString *)stringWithJSONObject:(id)obj;

/**
 字符串转换字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

- (NSString *)reverse;

+ (NSString *)replaceStringFormString:(NSString *)replace;

/**
 将 数字 0、1、2...9 转换成 零、一、二...九
 
 @param number 输入的数字
 @return 转换后的文字
 */
+ (NSString *)stringTransformNumberToString:(NSInteger)number;


#pragma mark - 所有的数字类型的字符处理类，包含：手机号码格式化、数字格式化等
/*!
 注意：中英文输出样式不一样，如果有国际化的请注意输出样式，
 本样式为中文输出环境，模拟器可能输出为英文样式
 */

/*! 手机号码格式化样式：344【中间空格】，示例：13855556666 --> 138 5555 6666 */
+ (NSString *)phoneNumberFormatterSpace:(NSString *)phoneNumber;

/*! 手机号码格式化样式：3*4【中间4位为*】，示例：13855556666 --> 138****6666 */
+ (NSString *)phoneNumberFormatterCenterStar:(NSString *)phoneNumber;

/*! 数字格式化样式，示例：12345678.89 --> 12,345,678.89 */
+ (NSString *)stringFormatterWithStyle:(NSNumberFormatterStyle)numberStyle numberString:(NSString *)numberString;

/*! 格式化为带小数点的数字，示例：12345678.89 --> 12,345,678.89 */
+ (NSString *)stringFormatterWithDecimalStyleWithNumberString:(NSString *)numberString;

/*! 格式化为货币样式，示例：12345678.89 --> 12,345,678.89 */
+ (NSString *)stringFormatterWithCurrencyStyleWithNumberString:(NSString *)numberString;

/*! 格式化为百分比样式，示例：12345678.89 --> 1,234,567,889% */
+ (NSString *)stringFormatterWithPercentStyleWithNumberString:(NSString *)numberString;

/*! 格式化为科学计数样式，示例：12345678.89 --> 1.234567889E7 */
+ (NSString *)stringFormatterWithScientificStyleWithNumberString:(NSString *)numberString;

/*! 格式化为英文输出样式（注：此处根据系统语言输出），示例：12345678.89 --> 一千二百三十四万五千六百七十八点八九 */
+ (NSString *)stringFormatterWithSpellOutStyleWithNumberString:(NSString *)numberString;

/*! 格式化为序数样式，示例：12345678.89 --> 第1234,5679 */
+ (NSString *)stringFormatterWithOrdinalStyleWithNumberString:(NSString *)numberString;

/*! 格式化为货币ISO代码样式样式，示例：123456889.86 --> CNY123,456,889.86 */
+ (NSString *)stringFormatterWithCurrencyISOCodeStyleWithNumberString:(NSString *)numberString;

/*! 格式化为货币多样式，示例：12345678.89 --> USD 12,345,678.89 */
+ (NSString *)stringFormatterWithCurrencyPluralStyleWithNumberString:(NSString *)numberString;

/*! 保留纯数字 */
- (NSString *)removeStringSaveNumber;

#pragma mark - 点赞数处理：2.1千，3.4万
/**
 点赞数处理：2.1千，3.4万
 
 @param string 传入的 string 类型的 数字
 @return 2.1千，3.4万
 */
+ (NSString *)stringTransformNumberWithString:(NSString *)string;

- (NSString *)stringByDeletingPictureResolution;

@end
NS_ASSUME_NONNULL_END
