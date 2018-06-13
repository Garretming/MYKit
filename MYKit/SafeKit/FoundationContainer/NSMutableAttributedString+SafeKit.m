//
//  NSMutableAttributedString+SafeKit.m
//  QMSafeKit
//
//  Created by David on 2018/3/23.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSMutableAttributedString+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"

@implementation NSMutableAttributedString (SafeKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        [self instanceSwizzleMethodWithClass:NSConcreteMutableAttributedString orginalMethod:@selector(appendAttributedString:) replaceMethod:@selector(safe_appendAttributedString:)];
        
        [self instanceSwizzleMethodWithClass:NSConcreteMutableAttributedString orginalMethod:@selector(initWithString:) replaceMethod:@selector(safe_initWithString:)];
        
        [self instanceSwizzleMethodWithClass:NSConcreteMutableAttributedString orginalMethod:@selector(initWithString:attributes:) replaceMethod:@selector(safe_initWithString:attributes:)];
    });
}

- (instancetype)safe_initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
    if (!str) {
        [self sf_showAddNilData_String_AttributedString];
        return nil;
    }
    if (!attrs) {
        [self sf_showAddNilData_String_AttributedString];
        return nil;
    }
    return [self safe_initWithString:str attributes:attrs];
}

- (instancetype)safe_initWithString:(NSString *)str {
    if (!str) {
        [self sf_showAddNilData_String_AttributedString];
        return nil;
    }
    return [self safe_initWithString:str];
}

- (void)safe_appendAttributedString:(NSAttributedString *)attrString {
    if (!attrString) {
        [self sf_showAddNilData_String_AttributedString];
        return;
    }
    [self safe_appendAttributedString:attrString];
}

@end
