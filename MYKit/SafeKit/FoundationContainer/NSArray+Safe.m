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

+ (void)registerClassPairMethodsInArray {
    
    Class __NSArray = NSClassFromString(@"NSArray");
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
    Class __NSArray0 = NSClassFromString(@"__NSArray0");
    
    // 防御对象实例方法
    // arrayWithObjects
    [self classSwizzleMethodWithClass:__NSArray orginalMethod:@selector(arrayWithObjects:count:) replaceMethod:@selector(safeArrayWithObjects:count:)];
    
    // objectAtIndex:
    [self instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForArrayI:)];
    
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForNSArray0:)];
    
    [self instanceSwizzleMethodWithClass:__NSSingleObjectArrayI orginalMethod:@selector(objectAtIndex:) replaceMethod:@selector(safe_objectAtIndexForSingleObjectArrayI:)];
    
    // objectAtIndexedSubscript
    [self instanceSwizzleMethodWithClass:__NSArrayI orginalMethod:@selector(objectAtIndexedSubscript:) replaceMethod:@selector(safe_objectAtIndexedSubscript:)];
    
    // arrayByAddingObject
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(arrayByAddingObject:) replaceMethod:@selector(safe_arrayByAddingObjectForNSArray0:)];
    
    // indexOfObject
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(indexOfObject:inRange:) replaceMethod:@selector(safe_indexOfObject:inRange:)];
    
    // indexOfObjectIdenticalTo
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(indexOfObjectIdenticalTo:inRange:) replaceMethod:@selector(safe_indexOfObjectIdenticalTo:inRange:)];
    
    // subarrayWithRange
    [self instanceSwizzleMethodWithClass:__NSArray0 orginalMethod:@selector(subarrayWithRange:) replaceMethod:@selector(safe_subarrayWithRange:)];
    
    // objectsAtIndexes:
    [self instanceSwizzleMethodWithClass:__NSArray orginalMethod:@selector(objectsAtIndexes:) replaceMethod:@selector(safe_objectsAtIndexesWithNSArray:)];
}

+ (instancetype)safeArrayWithObjects:(id _Nonnull const [])objects count:(NSUInteger)cnt {
    
    NSInteger newObjsIndex = 0;
    id  _Nonnull __unsafe_unretained newObjects[cnt];
    for (int i = 0; i < cnt; i++) {
        id objc = objects[i];
        if (objc == nil) {
            NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : Array constructor appear nil ",
                                [self class], NSStringFromSelector(@selector(arrayWithObjects:count:))];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
            continue;
        }
        newObjects[newObjsIndex++] = objc;
        
    }
    return [self safeArrayWithObjects:newObjects count:newObjsIndex];
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForArrayI:idx];
    } else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(objectAtIndexedSubscript:)), @(idx), @(self.count)];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
        return nil;
    }
}

- (id)safe_objectAtIndexForArrayI:(NSUInteger)index {
    
    if (index < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForArrayI:index];
    } else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
        return nil;
    }
}

- (id)safe_objectAtIndexForNSArray0:(NSUInteger)index {
    if (index < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForNSArray0:index];
    } else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
        return nil;
    }
}

- (id)safe_objectAtIndexForSingleObjectArrayI:(NSUInteger)index {
    if (index < [(NSArray *)self count]) {
        return [self safe_objectAtIndexForSingleObjectArrayI:index];
    } else {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@,reason : index %@ out of count %@ of array ",
                            [self class], NSStringFromSelector(@selector(objectAtIndex:)), @(index), @(self.count)];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
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

- (NSArray<id> *)safe_objectsAtIndexesWithNSArray:(NSIndexSet *)indexes {
    if (!indexes) {
        NSString *reason = [NSString stringWithFormat:@"\"%@\"-indexes:%@ cannot be set nil", NSStringFromSelector(_cmd), indexes];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
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
            NSString *reason = [NSString stringWithFormat:@"\"%@\"-indexes:%@ should be set at range [0, %lu)", NSStringFromSelector(_cmd), indexes, [(NSArray *)self count]];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:MYSafeKitShieldTypeContainer];
            return nil;
        }
        return [self safe_objectsAtIndexesWithNSArray:indexes];
    }
}

@end



