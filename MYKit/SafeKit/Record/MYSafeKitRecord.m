//
//  MYSafeKitRecord.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/31.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYSafeKitRecord.h"

@implementation MYSafeKitRecord

static id<MYSafeKitRecordProtocol> __record;

+ (void)registerRecordHandler:(id<MYSafeKitRecordProtocol>)record {
    __record = record;
}

+ (void)recordFatalWithReason:(nullable NSString *)reason
                    errorType:(MYSafeKitShieldType)type {
    
    NSDictionary<NSString *, id> *errorInfo = @{ NSLocalizedDescriptionKey : (reason.length ? reason : @"未标识原因" )};
    
    NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"com.xxshield.%@",
                                               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]]
                                         code:-type
                                     userInfo:errorInfo];
    [__record recordWithReason:error];
}

@end
