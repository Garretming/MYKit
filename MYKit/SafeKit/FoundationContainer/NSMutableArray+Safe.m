//
//  NSArray+Aspect.m
//  Footstone
//
//  Created by 李阳 on 8/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableArray (Safe)

+ (void)registerClassPairMethodsInMutableArray {
    
    Class __NSArrayM = NSClassFromString(@"__NSArrayM");
    
    // insert
    //FOR __NSArrayI
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(insertObject:atIndex:) replaceMethod:@selector(safe_insertObject:atIndex:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(insertObjects:atIndexes:) replaceMethod:@selector(safe_insertObjects:atIndexes:)];
    
    // remove
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObject:) replaceMethod:@selector(safe_removeObject:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObject:inRange:) replaceMethod:@selector(safe_removeObject:inRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObjectIdenticalTo:inRange:) replaceMethod:@selector(safe_removeObjectIdenticalTo:inRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObjectAtIndex:) replaceMethod:@selector(safe_removeObjectAtIndex:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObjectsInRange:) replaceMethod:@selector(safe_removeObjectsInRange:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(removeObjectsAtIndexes:) replaceMethod:@selector(safe_removeObjectsAtIndexes:)];
    
    // replace
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(replaceObjectAtIndex:withObject:) replaceMethod:@selector(safe_replaceObjectAtIndex:withObject:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(replaceObjectsAtIndexes:withObjects:) replaceMethod:@selector(safe_replaceObjectsAtIndexes:withObjects:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(exchangeObjectAtIndex:withObjectAtIndex:) replaceMethod:@selector(safe_exchangeObjectAtIndex:withObjectAtIndex:)];
    
#if TARGET_IPHONE_SIMULATOR  //模拟器
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(objectAtIndexedSubscript:) replaceMethod:@selector(safe_objectAtIndexedSubscript:)];
#endif
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(setObject:atIndexedSubscript:) replaceMethod:@selector(safe_atIndexedSubscript:atIndexedSubscript:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(replaceObjectsInRange:withObjectsFromArray:) replaceMethod:@selector(safe_replaceObjectsInRange:withObjectsFromArray:)];
    
    [self instanceSwizzleMethodWithClass:__NSArrayM orginalMethod:@selector(replaceObjectsInRange:withObjectsFromArray:range:) replaceMethod:@selector(safe_replaceObjectsInRange:withObjectsFromArray:range:)];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (!anObject) {
        NSLog(@"\"%@\"-object:(%@) is nil", NSStringFromSelector(_cmd), anObject);
        return;
    }
    if (index > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-index:(%lu) must at range [0, %lu)", NSStringFromSelector(_cmd), index, (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_insertObject:anObject atIndex:index];
}

- (void)safe_removeObject:(id)anObject inRange:(NSRange)range {
    
    if (range.location + range.length > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-range:%@ must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_removeObject:anObject inRange:range];
}

- (void)safe_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (range.location + range.length > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-range:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_removeObjectIdenticalTo:anObject inRange:range];
}

- (void)safe_removeObject:(id)anObject {
    
    [self safe_removeObject:anObject];
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    
    if (index < [(NSArray *)self count]) {
        [self safe_removeObjectAtIndex:index];
    } else {
        NSLog(@"\"%@\"-index:(%lu) must at range [0, %lu)", NSStringFromSelector(_cmd), index, (unsigned long)[(NSArray *)self count]);
    }
}

- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (!anObject) {
        NSLog(@"\"%@\"-object%@ must be not equal to nil", NSStringFromSelector(_cmd), anObject);
        return;
    }
    if (index > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-index:(%lu) must at range [0, %lu)", NSStringFromSelector(_cmd), index, (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

- (void)safe_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    if (idx1 >= [(NSArray *)self count]) {
        NSLog(@"\"%@\"-idx1:(%lu) must at range [0, %lu)", NSStringFromSelector(_cmd), idx1, (unsigned long)[(NSArray *)self count]);
        return;
    }
    if (idx2 >= [(NSArray *)self count]) {
        NSLog(@"\"%@\"-idx2:(%lu) must at range [0, %lu)", NSStringFromSelector(_cmd), idx2, (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count) {
        NSLog(@"*** -[__NSArrayM objectAtIndexedSubscript:]: index %ld beyond bounds [0 .. %ld]'",(unsigned long)idx,(unsigned long)self.count);
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:idx];
}

- (void)safe_removeObjectsInRange:(NSRange)range {
    if (range.location + range.length > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-range:(%@) should be at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_removeObjectsInRange:range];
}

- (void)safe_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    __block BOOL isPassed = YES;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL*stop) {
        NSLog(@"%lu", (unsigned long)idx);
        if (isPassed) {
            if (idx < [(NSArray *)self count]) {
                isPassed = YES;
            } else {
                isPassed = NO;
            }
        }
    }];
    if (!isPassed) {
        NSLog(@"\"%@\"-parameter0:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), indexes, (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_removeObjectsAtIndexes:indexes];
}

- (void)safe_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes {
    __block BOOL isPassed = YES;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL*stop) {
        NSLog(@"%lu", (unsigned long)idx);
        if (isPassed) {
            if (idx < [(NSArray *)self count]) {
                isPassed = YES;
            } else {
                isPassed = NO;
            }
        }
    }];
    if (!isPassed) {
        NSLog(@"\"%@\"-parameter0:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), indexes, (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_insertObjects:objects atIndexes:indexes];
}

- (void)safe_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects {
    
    __block BOOL isPassed = YES;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL*stop) {
        NSLog(@"%lu", (unsigned long)idx);
        if (isPassed) {
            if (idx < [(NSArray *)self count]) {
                isPassed = YES;
            } else {
                isPassed = NO;
            }
        }
    }];
    if (!isPassed) {
        NSLog(@"\"%@\"-parameter0:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), indexes, (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_replaceObjectsAtIndexes:indexes withObjects:objects];
}

- (void)safe_atIndexedSubscript:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (idx > [(NSMutableArray *)self count]) {
        NSLog(@"\"%@\"-idx:(%lu) must at range [0, %lu)", NSStringFromSelector(_cmd), idx, (unsigned long)[(NSArray *)self count]);
        return;
    }
    if (!obj) {
        NSLog(@"\"%@\"-obj:%@ cannot be set nil", NSStringFromSelector(_cmd), obj);
        return;
    }
    [self safe_atIndexedSubscript:obj atIndexedSubscript:idx];
}

- (void)safe_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray {
    
    if (range.location + range.length > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-parameter0:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (void)safe_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange {
    
    if (range.location + range.length > [(NSArray *)self count]) {
        NSLog(@"\"%@\"-parameter0:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(range), (unsigned long)[(NSArray *)self count]);
        return;
    }
    if (otherRange.location + otherRange.length > [otherArray count]) {
        NSLog(@"\"%@\"-parameter3:(%@) must at range [0, %lu)", NSStringFromSelector(_cmd), NSStringFromRange(otherRange), (unsigned long)[(NSArray *)self count]);
        return;
    }
    [self safe_replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
}

@end


