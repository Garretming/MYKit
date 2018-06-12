//
//  NSNumber+SafeKit.m
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSNumber+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"
#import "MessageTrash.h"

@implementation NSNumber (SafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_isEqualToNumber:) tarClass:@"__NSCFNumber" tarSel:@selector(isEqualToNumber:)];
        [self safe_swizzleMethod:@selector(safe_compare:) tarClass:@"__NSCFNumber" tarSel:@selector(compare:)];
    });
}

- (BOOL)safe_isEqualToNumber:(NSNumber *)number {
    if (!number) {
        [self sf_showAddNilData_Number];
        return NO;
    }
    return [self safe_isEqualToNumber:number];
}

- (NSComparisonResult)safe_compare:(NSNumber *)number {
    if (!number) {
        [self sf_showAddNilData_Number];
        return NSOrderedAscending;
    }
    return [self safe_compare:number];
}

@end
