//
//  NSDictionary+SafeKit.m
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSDictionary+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "MessageTrash.h"

@implementation NSDictionary (SafeKit)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(initWithObjects_safe:forKeys:count:) tarClass:@"__NSPlaceholderDictionary" tarSel:@selector(initWithObjects:forKeys:count:)];
    });
}

- (instancetype)initWithObjects_safe:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_safe:objects forKeys:keys count:newCnt];
    return self;
}

/*
 - (id)forwardingTargetForSelector:(SEL)aSelector {
 //    [self sf_showUnknowSelectorError];
    return [MessageTrash new];
 }
 */

@end
