//
//  NSMutableDictionary+NilSafe.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSMutableDictionary+NilSafe.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        
        [class swizzleInstanceMethod:@selector(setObject:forKey:) with:@selector(gl_setObject:forKey:)];
        
        [class swizzleInstanceMethod:@selector(setObject:forKeyedSubscript:) with:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
    }
    [self gl_setObject:obj forKeyedSubscript:key];
}

@end
