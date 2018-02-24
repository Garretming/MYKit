//
//  NSDictionary+NilSafe.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/2/24.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSDictionary+NilSafe.h"
#import "NSObject+Swizzling.h"

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(initWithObjects:forKeys:count:) with:@selector(gl_initWithObjects:forKeys:count:)];
        
        [self swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) with:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects
                                 forKeys:(const id<NSCopying> [])keys
                                   count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects
                           forKeys:(const id<NSCopying> [])keys
                             count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end
