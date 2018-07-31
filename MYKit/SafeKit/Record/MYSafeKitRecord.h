//
//  MYSafeKitRecord.h
//  MYKitDemo
//
//  Created by QMMac on 2018/7/31.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYSafeKit.h"

@interface MYSafeKitRecord : NSObject

/**
 注册汇报中心
 
 @param record 汇报中心
 */
+ (void)registerRecordHandler:(nullable id<MYSafeKitRecordProtocol>)record;

/**
 汇报Crash
 
 @param reason Sting 原因， maybe nil
 */
+ (void)recordFatalWithReason:(nullable NSString *)reason
                    errorType:(MYSafeKitShieldType)type;

@end
