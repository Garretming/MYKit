//
//  NSMutableDictionary+SafeKit.m
//  QMSafeKit
//
//  Created by David on 2018/3/23.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSMutableDictionary+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"
#import "MessageTrash.h"

@implementation NSMutableDictionary (SafeKit)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_removeObjectForKey:) tarClass:@"__NSDictionaryM" tarSel:@selector(removeObjectForKey:)];
        [self safe_swizzleMethod:@selector(safe_setObject:forKey:) tarClass:@"__NSDictionaryM" tarSel:@selector(setObject:forKey:)];
        
    });
}

- (void)safe_removeObjectForKey:(id)aKey {
    if (!aKey) {
        [self sf_showAddNilData_Dictionary];
        return;
    }
    [self safe_removeObjectForKey:aKey];
}

- (void)safe_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject) {
        [self sf_showAddNilData_Dictionary];
        return;
    }
    if (!aKey) {
        [self sf_showAddNilData_Dictionary];
        return;
    }
    [self safe_setObject:anObject forKey:aKey];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [MessageTrash new];
}

@end
