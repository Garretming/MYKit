//
//  NSArray+SafeKit.m
//  QMSafeKit
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSArray+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"
#import "MessageTrash.h"

@implementation NSArray (SafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //FOR __NSArrayI
        [self safe_swizzleMethod:@selector(safe_objectAtIndex:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndex:)];
        [self safe_swizzleMethod:@selector(safe_arrayByAddingObject:) tarClass:@"__NSArrayI" tarSel:@selector(arrayByAddingObject:)];
        
        //FOR __NSSingleObjectArrayI
        [self safe_swizzleMethod:@selector(safe_singleObjectAtIndex:) tarClass:@"__NSSingleObjectArrayI" tarSel:@selector(objectAtIndex:)];
        
        //FOR __NSArray0
        [self safe_swizzleMethod:@selector(safe_objectAtIndexForNSArray0:) tarClass:@"__NSArray0" tarSel:@selector(objectAtIndex:)];
        
        // FOR IOS11
        // IOS11 objectAtIndexedSubscript： 代替  objectAtIndex：
        if (SF_APP_Version(11.0)) {
            [self safe_swizzleMethod:@selector(safe_NSArrayI_objectAtIndexedSubscript:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndexedSubscript:)];
        }
    });
}

- (id)safe_NSArrayI_objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self count]) {
        [self sf_showObjectAtIndexError_Array];
        return nil;
    }
    return [self safe_NSArrayI_objectAtIndexedSubscript:index];
}

- (id)safe_objectAtIndexForNSArray0:(NSUInteger)index {
    if (index >= [self count]) {
        [self sf_showObjectAtIndexError_Array];
        return nil;
    }
    return [self safe_objectAtIndexForNSArray0:index];
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    id obj = nil;
    @try {
        obj = [self safe_objectAtIndex:index];
    } @catch (NSException *exception) {
        [self sf_showObjectAtIndexError_Array];
        return obj;
    }
    return obj;
}

- (id)safe_singleObjectAtIndex:(NSInteger)index {
    id obj = nil;
    @try {
        obj = [self safe_singleObjectAtIndex:index];
    } @catch (NSException *exception) {
        [self sf_showObjectAtIndexError_Array];
        return obj;
    }
    return obj;
}

- (NSArray *)safe_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        [self sf_showAddNilData_Array];
        return self;
    }
    return [self safe_arrayByAddingObject:anObject];
}


/*
 - (id)forwardingTargetForSelector:(SEL)aSelector {
 //    [self sf_showUnknowSelectorError];
    return [MessageTrash new];
 }
 */


@end
