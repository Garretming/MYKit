//
//  NSMutableArray+SafeKit.m
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSMutableArray+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"
#import "MessageTrash.h"

@implementation NSMutableArray (SafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_addObject:) tarClass:@"__NSArrayM" tarSel:@selector(addObject:)];
        [self safe_swizzleMethod:@selector(safe_insertObject:atIndex:) tarClass:@"__NSArrayM" tarSel:@selector(insertObject:atIndex:)];
        [self safe_swizzleMethod:@selector(safe_removeObjectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(removeObjectAtIndex:)];
        [self safe_swizzleMethod:@selector(safe_replaceObjectAtIndex:withObject:) tarClass:@"__NSArrayM" tarSel:@selector(replaceObjectAtIndex:withObject:)];
        
        // FOR IOS11
        // IOS11 objectAtIndexedSubscript： 代替  objectAtIndex：
        if (SF_APP_Version(11.0)) {
            [self safe_swizzleMethod:@selector(safe_NSArrayM_objectAtIndexedSubscript:) tarClass:@"__NSArrayM" tarSel:@selector(objectAtIndexedSubscript:)];
        }
    });
}

- (id)safe_NSArrayM_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self count]) {
        [self sf_showObjectAtIndexError_Array];
        return nil;
    }
    return [self safe_NSArrayM_objectAtIndexedSubscript:index];
}

- (void)safe_addObject:(id)anObject {
    if (!anObject) {
        [self sf_showAddNilData_Array];
        return;
    }
    [self safe_addObject:anObject];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > [self count]) {
        [self sf_showObjectAtIndexError_Array];
        return;
    }
    if (!anObject) {
        [self sf_showAddNilData_Array];
        return;
    }
    [self safe_insertObject:anObject atIndex:index];
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        [self sf_showObjectAtIndexError_Array];
        return;
    }
    
    return [self safe_removeObjectAtIndex:index];
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        [self sf_showObjectAtIndexError_Array];
        return;
    }
    if (!anObject) {
        [self sf_showAddNilData_Array];
        return;
    }
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

/*
 - (id)forwardingTargetForSelector:(SEL)aSelector {
 //    [self sf_showUnknowSelectorError];
 return [MessageTrash new];
 }
 */

@end
