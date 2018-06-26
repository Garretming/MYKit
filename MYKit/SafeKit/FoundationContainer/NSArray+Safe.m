//
//  NSArray+Aspect.m
//  Footstone
//
//  Created by 李阳 on 8/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+Swizzle.h"

@implementation NSArray (Safe)

+ (void)registerClassPairMethodsInNSArray {
    
    Class __NSArray = NSClassFromString(@"NSArray");
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
    Class __NSArray0 = NSClassFromString(@"__NSArray0");
    
    // 防御对象实例方法
    [self classSwizzleMethodWithClass:__NSArray orginalMethod:@selector(arrayWithObjects:count:) replaceMethod:@selector(safeArrayWithObjects:count:)];
    
    //FOR __NSArrayI
    [self instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForArrayI:)];
    
    //FOR __NSArray0
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForNSArray0:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(arrayByAddingObject:) replaceMethod:@selector(safe_arrayByAddingObjectForNSArray0:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(indexOfObject:inRange:) replaceMethod:@selector(safe_indexOfObject:inRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(indexOfObjectIdenticalTo:inRange:) replaceMethod:@selector(safe_indexOfObjectIdenticalTo:inRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(subarrayWithRange:) replaceMethod:@selector(safe_subarrayWithRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(objectsAtIndexes:) replaceMethod:@selector(safe_objectsAtIndexes:)];
    
    //FOR __NSSingleObjectArrayI
    [self instanceSwizzleMethodWithClass:__NSSingleObjectArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForSingleObjectArrayI:)];
}

+ (instancetype)safeArrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    for (int i = 0; i<cnt; i++) {
        if (objects[i]) {
            objectsNew[index] = objects[i];
            index++;
        } else {
            NSLog(@"*** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[%d]",i);
        }
    }
    return [self safeArrayWithObjects:objectsNew count:index];
}

- (id)safe_objectAtIndexForArrayI:(NSUInteger)index {
    if (index < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForArrayI:index];
    } else {
        NSLog(@"\"%@\" -index:(%lu) should less than %lu", NSStringFromSelector(_cmd), index, (unsigned long)[(NSArray *)self count]);
        return nil;
    }
}

- (id)safe_objectAtIndexForNSArray0:(NSUInteger)index {
    if (index < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForNSArray0:index];
    } else {
        NSLog(@"\"%@\" -index:(%lu) should less than %lu", NSStringFromSelector(_cmd), index, (unsigned long)[(NSArray *)self count]);
        return nil;
    }
}

- (id)safe_objectAtIndexForSingleObjectArrayI:(NSUInteger)index {
    if (index < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForSingleObjectArrayI:index];
    } else {
        NSLog(@"\"%@\" -index:(%lu) should less than %lu", NSStringFromSelector(_cmd), index, (unsigned long)[(NSArray *)self count]);
        return nil;
    }
}

- (NSArray<id> *)safe_arrayByAddingObjectForNSArray0:(id)anObject {
    if (anObject != nil) {
        return [self safe_arrayByAddingObjectForNSArray0:anObject];
    } else {
        NSLog(@"\"%@\" -object:%@ cannot be set nil", NSStringFromSelector(_cmd), anObject);
        return nil;
    }
}

- (NSUInteger)safe_indexOfObject:(id)anObject inRange:(NSRange)range {
    
    if (!anObject) {
        NSLog(@"\"%@\" -object:%@ cannot be set nil", NSStringFromSelector(_cmd), anObject);
        return LONG_MAX;
    }
    
    if (range.location + range.length <= ((NSArray *)self).count)  {
        return [self safe_indexOfObject:anObject inRange:range];
    } else {
        NSLog(@"\"%@\"-range:%@ should be at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return LONG_MAX;
    }
}

- (NSUInteger)safe_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (range.location + range.length <= ((NSArray *)self).count)  {
        return [self safe_indexOfObjectIdenticalTo:anObject inRange:range];
    } else {
        NSLog(@"\"%@\"-range:%@ must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return LONG_MAX;
    }
}

- (NSArray<id> *)safe_subarrayWithRange:(NSRange)range {
    
    if (range.location + range.length <= [(NSArray *)self count]) {
        return [self safe_subarrayWithRange:range];
    } else {
        NSLog(@"\"%@\"-index:%@ must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray*)self count]);
        return nil;
    }
}

- (NSArray<id> *)safe_objectsAtIndexes:(NSIndexSet *)indexes {
    if (!indexes) {
        NSLog(@"\"%@\"-indexes:%@ cannot be set nil", NSStringFromSelector(_cmd), indexes);
        return nil;
    } else {
        __block BOOL isPass = YES;
        [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            if (isPass) {
                if (idx < [(NSArray *)self count]) {
                    isPass = YES;
                } else {
                    isPass = NO;
                }
            }
        }];
        if (!isPass) {
            NSLog(@"\"%@\"-indexes:%@ should be set at range [0, %lu)", NSStringFromSelector(_cmd), indexes, [(NSArray *)self count]);
            return nil;
        }
        return [self safe_objectsAtIndexes:indexes];
    }
}

@end



