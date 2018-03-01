//
//  NSMutableDictionary+NilSafe.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NilSafe)

/**
 安全的根据一个键获取对应的对象
 
 @param key key
 @return id
 */
- (id)my_safeObjectForKey:(id)key;

/**
 安全的根据value获取对应的key
 
 @param value id object
 @return id
 */
- (id)my_safeKeyForValue:(id)value;

@end
