//
//  NSArray+Extension.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Extension)

/**
 求和
 
 @return 总和
 */
- (CGFloat)getSum;

/**
 求最大值
 
 @return 最大值
 */
- (CGFloat)getMax;

/**
 随机交换数组的元素
 
 @return 新数组
 */
- (NSArray *)randomCopy;

/**
 *  创建反向数组
 */
- (NSArray *)reversedArray;

/**
 *  转换成JSON的NSString
 */
- (NSString *)arrayToJson;

@end
NS_ASSUME_NONNULL_END
