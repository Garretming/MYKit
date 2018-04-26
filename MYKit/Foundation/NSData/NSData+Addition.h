//
//  NSData+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/13.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Addition)

/**
 *  @brief  将APNS NSData类型token 格式化成字符串
 *
 *  @return 整理过后的字符串token
 */
- (NSString *)APNSToken;

@end
NS_ASSUME_NONNULL_END
