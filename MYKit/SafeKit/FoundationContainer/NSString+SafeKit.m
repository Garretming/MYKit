//
//  NSString+SafeKit.m
//  QMSafeKit
//
//  Created by David on 2018/3/23.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSString+SafeKit.h"
#import "NSObject+Swizzle.h"
#import "NSObject+SafeKitSetting.h"

@implementation NSString (SafeKit)

+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class __NSCFString = NSClassFromString(@"__NSCFString");
        
        //characterAtIndex:
        [self instanceSwizzleMethodWithClass:__NSCFString orginalMethod:@selector(characterAtIndex:) replaceMethod:@selector(safe_characterAtIndex:)];
        
        //substringWithRange:
        [self instanceSwizzleMethodWithClass:__NSCFString orginalMethod:@selector(substringWithRange:) replaceMethod:@selector(safe_substringWithRange:)];
    });
}

- (unichar)safe_characterAtIndex:(NSUInteger)index {
    if (index >= [self length]) {
        [self sf_showObjectAtIndexError_String];
        return 0;
    }
    return [self safe_characterAtIndex:index];
}

- (NSString *)safe_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        [self sf_showObjectAtIndexError_String];
        return @"";
    }
    return [self safe_substringWithRange:range];
}

@end
