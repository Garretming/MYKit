//
//  MYSafeFoundationContainer.h
//  MYKitDemo
//
//  Created by QMMac on 2018/6/26.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSafeFoundationContainer : NSObject

/// 防御 发送到未知的选择子到实例
+ (void)safeGuardContainersSelector;

@end
