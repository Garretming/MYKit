//
//  NSNull+SafeKit.h
//  MYKitDemo
//
//  Created by QMMac on 2018/6/21.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (SafeKit)

/**
 防护发送到未知的选择子到实例
 */
+ (void)safeGuardNullSelector;

@end
