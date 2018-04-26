//
//  NSString+Contains.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Contains)

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;

/**
 *  @brief 获取字符数量
 */
- (int)wordsCount;

/**
 判断URL中是否包含中文
 */
- (BOOL)isContainChinese;

@end
