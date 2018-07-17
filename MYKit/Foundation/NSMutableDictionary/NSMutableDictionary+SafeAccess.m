//
//  NSMutableDictionary+SafeAccess.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSMutableDictionary+SafeAccess.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableDictionary (SafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        
        [self classSwizzleMethodWithClass:class orginalMethod:@selector(setObject:forKey:) replaceMethod:@selector(my_setObject:forKey:)];
        
        [self classSwizzleMethodWithClass:class orginalMethod:@selector(setObject:forKeyedSubscript:) replaceMethod:@selector(my_setObject:forKeyedSubscript:)];
    });
}

- (void)my_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self my_setObject:anObject forKey:aKey];
}

- (void)my_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
    }
    [self my_setObject:obj forKeyedSubscript:key];
}

- (id)my_safeObjectForKey:(id)key {
    
    if (key != nil) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

- (id)my_safeKeyForValue:(id)value {
    
    for (id key in self.allKeys) {
        if ([value isEqual:[self objectForKey:key]]) {
            return key;
        }
    }
    return nil;
}

@end
