//
//  NSArray+Aspect.m
//  Footstone
//
//  Created by 李阳 on 8/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzle.h"
#import "MYSafeKitRecord.h"

@implementation NSArray (Safe)

+ (void)registerClassPairMethodsInNSArray {
    
    Class __NSArray = NSClassFromString(@"NSArray");
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
    Class __NSArray0 = NSClassFromString(@"__NSArray0");
    
    // 防御对象实例方法
    // insertNil
    [self classSwizzleMethodWithClass:__NSArray orginalMethod:@selector(arrayWithObjects:count:) replaceMethod:@selector(safeArrayWithObjects:count:)];
    
    // objectAtIndex:
    //FOR __NSArrayI
    [self instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForArrayI:)];
    
    //FOR __NSArray0
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForNSArray0:)];
  
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(arrayByAddingObject:) replaceMethod:@selector(safe_arrayByAddingObjectForNSArray0:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(indexOfObject:inRange:) replaceMethod:@selector(safe_indexOfObject:inRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(indexOfObjectIdenticalTo:inRange:) replaceMethod:@selector(safe_indexOfObjectIdenticalTo:inRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(subarrayWithRange:) replaceMethod:@selector(safe_subarrayWithRange:)];
    
    // objectsAtIndexes:
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(objectsAtIndexes:) replaceMethod:@selector(safe_objectsAtIndexes:)];
    
    //FOR __NSSingleObjectArrayI
    [self instanceSwizzleMethodWithClass:__NSSingleObjectArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForSingleObjectArrayI:)];
    
    
#if TARGET_IPHONE_SIMULATOR  //模拟器
    [self instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndexedSubscript:) replaceMethod:@selector(safe_objectAtIndexedSubscript:)];
#elif TARGET_OS_IPHONE      //真机
    
#endif
}

//objectAtIndexedSubscript
- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx >= self.count) {
        //记录错误
        NSString *errorInfo = [NSString stringWithFormat:@"*** -[__NSArrayI objectAtIndexedSubscript:]: index %ld beyond bounds [0 .. %ld]'",(unsigned long)idx,(unsigned long)self.count];
        NSLog(@"%@", errorInfo);
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:idx];
}

+ (instancetype)safeArrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    for (int i = 0; i<cnt; i++) {
        if (objects[i]) {
            objectsNew[index] = objects[i];
            index++;
        } else {
            // 记录错误
            NSString *errorInfo = [NSString stringWithFormat:@"*** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[%d]",i];
            NSLog(@"%@", errorInfo);
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



