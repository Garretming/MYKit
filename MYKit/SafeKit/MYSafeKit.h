//
//  MYSafeKit.h
//  MYKitDemo
//
//  Created by QMMac on 2018/6/26.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, MYSafeKitShieldType) {
    MYSafeKitShieldTypeUnrecognizedSelector = 1 << 1,
    MYSafeKitShieldTypeContainer = 1 << 2,
    MYSafeKitShieldTypeNSNull = 1 << 3,
    MYSafeKitShieldTypeKVO = 1 << 4,
    MYSafeKitShieldTypeNotification = 1 << 5,
    MYSafeKitShieldTypeTimer = 1 << 6,
    MYSafeKitShieldTypeAll,
};

@protocol MYSafeKitRecordProtocol <NSObject>

- (void)recordWithReason:(NSError *)reason;

@end

@interface MYSafeKit : NSObject

/**
 注册 SDK，默认只要开启就打开防 Crash
 */
+ (void)registerSafeKitShield;

/**
 注册 SDK，根据不同 ability 开启防 Crash
 本注册方式不包含 MYSafeKitShieldTypeAll 类型
 @param ability ability
 */
+ (void)registerSafeKitShieldWithAbility:(MYSafeKitShieldType)ability;

@end
