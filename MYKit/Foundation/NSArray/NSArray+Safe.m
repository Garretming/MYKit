//
//  NSArray+Safe.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/1/9.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

static inline void swizzling_exchangeMethod(Class clazz, SEL originalSelector, SEL exchangeSelector) {
    // 获取原方法
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    
    // 获取需要交换的方法
    Method exchangeMethod = class_getInstanceMethod(clazz, exchangeSelector);
    
    if (class_addMethod(clazz, originalSelector, method_getImplementation(exchangeMethod), method_getTypeEncoding(exchangeMethod))) {
        class_replaceMethod(clazz, exchangeSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, exchangeMethod);
    }
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzling_exchangeMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(emptyArray_objectAtIndex:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(arrayI_objectAtIndex:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(arrayM_objectAtIndex:));
        swizzling_exchangeMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(singleObjectArrayI_objectAtIndex:));
        
        swizzling_exchangeMethod(objc_getClass("__NSArray0"), @selector(objectAtIndexedSubscript:), @selector(emptyArray_objectAtIndexedSubscript:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:), @selector(arrayI_objectAtIndexedSubscript:));
        swizzling_exchangeMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(arrayM_objectAtIndexedSubscript:));
        swizzling_exchangeMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(singleObjectArrayI_objectAtIndexedSubscript:));
    });
}

#pragma MARK -  - (id)objectAtIndex:
- (id)emptyArray_objectAtIndex:(NSUInteger)index{
    return nil;
}

- (id)arrayI_objectAtIndex:(NSUInteger)index{
    if(index < self.count){
        return [self arrayI_objectAtIndex:index];
    }
    return nil;
}

- (id)arrayM_objectAtIndex:(NSUInteger)index{
    if(index < self.count){
        return [self arrayM_objectAtIndex:index];
    }
    return nil;
}

- (id)singleObjectArrayI_objectAtIndex:(NSUInteger)index{
    if(index < self.count){
        return [self singleObjectArrayI_objectAtIndex:index];
    }
    return nil;
}

#pragma MARK -  - (id)objectAtIndexedSubscript:
- (id)emptyArray_objectAtIndexedSubscript:(NSUInteger)index{
    return nil;
}

- (id)arrayI_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self arrayI_objectAtIndex:index];
    }
    return nil;
}

- (id)arrayM_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self arrayM_objectAtIndex:index];
    }
    return nil;
}

- (id)singleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)index{
    if(index < self.count){
        return [self singleObjectArrayI_objectAtIndexedSubscript:index];
    }
    return nil;
}

@end
