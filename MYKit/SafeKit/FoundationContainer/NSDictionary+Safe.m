//
//  NSDictionary+Safe.m
//  Footstone
//
//  Created by 李阳 on 4/5/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSDictionary (Safe)

+ (void)registerClassPairMethodsInDictionary {
    
    Class dictionaryClass = NSClassFromString(@"NSDictionary");
    Class __NSPlaceholderDictionaryClass = NSClassFromString(@"__NSPlaceholderDictionary");
    
    [self classSwizzleMethodWithClass:dictionaryClass orginalMethod:@selector(dictionaryWithObjects:forKeys:count:) replaceMethod:@selector(safe_dictionaryWithObjects:forKeys:count:)];
    
    [self instanceSwizzleMethodWithClass:__NSPlaceholderDictionaryClass orginalMethod:@selector(initWithObjects:forKeys:count:) replaceMethod:@selector(safe_initWithObjects:forKeys:count:)];
    
    [self instanceSwizzleMethodWithClass:__NSPlaceholderDictionaryClass orginalMethod:@selector(objectsForKeys:notFoundMarker:) replaceMethod:@selector(safe_objectsForKeys:notFoundMarker:)];
}

+ (instancetype)safe_dictionaryWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    return [self safe_dictionaryWithObjects:objects forKeys:keys count:cnt];
}

+ (instancetype)safe_dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys{
    if (objects.count != keys.count) {
        NSLog(@"*** -[NSDictionary initWithObjects:forKeys:]: count of objects (%ld) differs from count of keys (%ld)",(unsigned long)objects.count,(unsigned long)keys.count);
        return nil;
    }
    NSUInteger index = 0;
    id _Nonnull objectsNew[objects.count];
    id <NSCopying> _Nonnull keysNew[keys.count];
    for (int i = 0; i<keys.count; i++) {
        if (objects[i] && keys[i]) {
            objectsNew[index] = objects[i];
            keysNew[index] = keys[i];
            index ++;
        } else {
            NSLog(@"*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]",i);
        }
    }
    return [self safe_dictionaryWithObjects:[NSArray arrayWithObjects:objectsNew count:index] forKeys: [NSArray arrayWithObjects:keysNew count:index]];
}

- (instancetype)safe_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    NSUInteger index = 0;
    id _Nonnull objectsNew[cnt];
    id <NSCopying> _Nonnull keysNew[cnt];
    //'*** -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)'
    for (int i = 0; i<cnt; i++) {
        if (objects[i] && keys[i]) {//可能存在nil的情况
            objectsNew[index] = objects[i];
            keysNew[index] = keys[i];
            index ++;
        } else {
            NSLog(@"*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[%d]",i);
        }
    }
    return [self safe_initWithObjects:objectsNew forKeys:keysNew count:index];
}

- (NSArray<id> *)safe_objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker {
    if (!marker) {
        NSLog(@"\"%@\"-parameter1:(%@) cannot be nil", NSStringFromSelector(_cmd), marker);
        return nil;
    }
    return [self safe_objectsForKeys:keys notFoundMarker:marker];
}

@end



