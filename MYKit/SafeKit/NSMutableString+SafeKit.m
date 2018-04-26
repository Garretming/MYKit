//
//  NSMutableString+SafeKit.m
//  QMSafeKit
//
//  Created by David on 2018/3/23.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSMutableString+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"
#import "MessageTrash.h"

@implementation NSMutableString (SafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_appendString:) tarClass:@"__NSCFConstantString" tarSel:@selector(appendString:)];
        [self safe_swizzleMethod:@selector(safe_appendFormat:) tarClass:@"__NSCFConstantString" tarSel:@selector(appendFormat:)];
        [self safe_swizzleMethod:@selector(safe_setString:) tarClass:@"__NSCFConstantString" tarSel:@selector(setString:)];
        [self safe_swizzleMethod:@selector(safe_insertString:atIndex:) tarClass:@"__NSCFConstantString" tarSel:@selector(insertString:atIndex:)];
        
    });
}

- (void)safe_appendString:(NSString *)aString {
    if (!aString) {
        [self sf_showAddNilData_String];
        return;
    }
    [self safe_appendString:aString];
}

- (void)safe_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    if (!format) {
        [self sf_showAddNilData_String];
        return;
    }
    va_list arguments;
    va_start(arguments, format);
    NSString *formatStr = [[NSString alloc]initWithFormat:format arguments:arguments];
    [self safe_appendFormat:@"%@",formatStr];
    va_end(arguments);
}

- (void)safe_setString:(NSString *)aString {
    if (!aString) {
        [self sf_showAddNilData_String];
        return;
    }
    [self safe_setString:aString];
}

- (void)safe_insertString:(NSString *)aString atIndex:(NSUInteger)index {
    if (index > [self length]) {
        [self sf_showObjectAtIndexError_String];
        return;
    }
    if (!aString) {
        [self sf_showAddNilData_String];
        return;
    }
    
    [self safe_insertString:aString atIndex:index];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [MessageTrash new];
}

@end
