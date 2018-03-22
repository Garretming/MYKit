//
//  UIDevice+Extension.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)

/**
 获取UUID
 */
+ (NSString *)generateUuidString;
/**
 设备版本
 */
+ (NSString*)deviceModel;

/**
 手机系统版本
 */
+ (NSString *)systemVersion;

/**
 IFV/IDFV (Identifier for Vendor)
 */
+ (NSString *)appleIFV;

/**
 获取当前版本号
 */
+ (NSString *)getVersionNumber;

+ (NSString *)platform;

+ (BOOL)isSimulator;

+ (NSString *)platformString;

+ (BOOL)p35InchDisplay;

+ (BOOL)p4InchDisplay;

+ (BOOL)p47InchDisplay;

+ (BOOL)p55InchDiplay;

+ (BOOL)isIphoneX;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/**
 获取当前网络运营商的名称
 @return 中国移动/中国联通/中国电信或者其他运营商
 */
+ (NSString *)getCarrierName;

/**
 获取当前设备的CPU数量
 @return NSUInteger
 */
+ (NSUInteger)getCurrentDeviceCPUCount;

/**
 获取当前设备CPU总的使用百分比
 @return CGFloat
 */
+ (CGFloat)getCurrentDeviceAllCoreCPUUse;

/**
 获取当前设备单个CPU使用的百分比
 @return NSArray;
 */
+ (NSArray *)getCurrentDeviceSingleCoreCPUUse;

/**
 获取当前设备的单元网络地址
 @return NSString
 */
+ (NSString *)getCurrentDeviceIPAddressWithCell;

/**
 获取当前设备的WiFi地址
 @return NSString
 */
+ (NSString *)getCurrentDeviceIPAddressWithWiFi;

/**
 获取当前设备的IP地址
 
 @return NSString
 */
+ (NSString *)getCurrentDeviceIPAddresses;


@end
