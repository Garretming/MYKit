//
//  NSDictionary+Safe.m
//  Footstone
//
//  Created by 李阳 on 4/5/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+Swizzle.h"

@implementation NSMutableDictionary (Safe)

+ (void)registerClassPairMethodsInMutableDictionary {
    
    Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
    
    [self instanceSwizzleMethodWithClass:dictionaryM orginalMethod:@selector(setObject:forKey:) replaceMethod:@selector(safe_setObject:forKey:)];
    
    [self instanceSwizzleMethodWithClass:dictionaryM orginalMethod:@selector(removeObjectForKey:) replaceMethod:@selector(safe_removeObjectForKey:)];
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        NSLog(@"\"%@\"-parameter0:(%@) cannot be nil", NSStringFromSelector(_cmd), anObject);
        return;
    }
    if (!aKey) {
        NSLog(@"\"%@\"-parameter1:(%@) cannot be nil", NSStringFromSelector(_cmd), aKey);
        return;
    }
    [self safe_setObject:anObject forKey:aKey];
}

- (void)safe_removeObjectForKey:(id)aKey {
    if (!aKey) {
        NSLog(@"\"%@\"-parameter0:(%@) cannot be nil", NSStringFromSelector(_cmd), aKey);
        return;
    }
    [self safe_removeObjectForKey:aKey];
}

@end

