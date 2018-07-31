//
//  NSMutableString+Safe.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/30.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSMutableString+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableString (Safe)

+ (void)registerClassPairMethodsInMutableString {
    
    Class NSCFString = NSClassFromString(@"__NSCFString");
    
    [self instanceSwizzleMethodWithClass:NSCFString orginalMethod:@selector(replaceCharactersInRange:withString:) replaceMethod:@selector(safe_replaceCharactersInRange:withString:)];
    
    [self instanceSwizzleMethodWithClass:NSCFString orginalMethod:@selector(insertString:atIndex:) replaceMethod:@selector(safe_insertString:atIndex:)];
    
    [self instanceSwizzleMethodWithClass:NSCFString orginalMethod:@selector(deleteCharactersInRange:) replaceMethod:@selector(safe_deleteCharactersInRange:)];
}

- (void)safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (range.location+range.length > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"*** -[__NSCFString replaceCharactersInRange:withString:]: Range or index out of bounds"];
        NSLog(@"%@", errorInfo);
        if (range.location < self.length) {
            [self safe_replaceCharactersInRange:NSMakeRange(range.location, self.length-range.location) withString:aString];
        }
    } else {
        [self safe_replaceCharactersInRange:range withString:aString];
    }
}

- (void)safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (loc > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"*** -[__NSCFString insertString:atIndex:]: Range or index out of bounds"];
        NSLog(@"%@", errorInfo);
    } else {
        [self safe_insertString:aString atIndex:loc];
    }
}

- (void)safe_deleteCharactersInRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        NSString *errorInfo = [NSString stringWithFormat:@"*** -[__NSCFString deleteCharactersInRange:]: Range or index out of bounds"];
        NSLog(@"%@", errorInfo);
        if (range.location < self.length) {
            [self safe_deleteCharactersInRange:NSMakeRange(range.location, self.length - range.location)];
        }
    } else {
        [self safe_deleteCharactersInRange:range];
    }
}

@end
