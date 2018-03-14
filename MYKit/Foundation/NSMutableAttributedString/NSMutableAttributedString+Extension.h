//
//  NSMutableAttributedString+Extension.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/14.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Extension)

/**
 添加图片在字符串之前
 
 @param subffixString 字符串
 @param subffixImage 图片
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)attributeStringWithSubffixString:(NSString *)subffixString subffixImage:(UIImage *)subffixImage;

/**
 添加多张图片在字符串之前
 
 @param subffixString 字符串
 @param subffixImages 图片数组
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)attributeStringWithSubffixString:(NSString *)subffixString subffixImages:(NSArray<UIImage *> *)subffixImages;
/**
 添加图片在字符串之后
 
 @param prefixString 富文本
 @param prefixImage 图片
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString prefixImage:(UIImage *)prefixImage;

/**
 添加多张图片在字符串之前
 
 @param prefixString 字符串
 @param prefixImages 图片数组
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)attributeStringWithPrefixString:(NSString *)prefixString prefixImages:(NSArray<UIImage *> *)prefixImages;

/**
 给指定字符串设置行距
 
 @param string 字符串
 @param lineSpacing 行距
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing;

/**
 给指定字符串设置行距
 
 @param attributedString NSAttributedString
 @param lineSpacing 行距
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)attributedStringWithAttributedString:(NSAttributedString *)attributedString lineSpacing:(CGFloat)lineSpacing;

@end
