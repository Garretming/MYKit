//
//  NSObject+SafeKVO.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/30.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "NSObject+SafeKVO.h"
#import "NSObject+Swizzle.h"
#import "MYSafeKitRecord.h"

static void(*__xx_hook_orgin_function_removeObserver)(NSObject* self, SEL _cmd ,NSObject *observer ,NSString *keyPath) = ((void*)0);

@interface XXKVOProxy : NSObject {
    __unsafe_unretained NSObject *_observed;
}

/**
 {keypath : [ob1,ob2](NSHashTable)}
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSHashTable<NSObject *> *> *kvoInfoMap;

@end

@implementation XXKVOProxy

- (instancetype)initWithObserverd:(NSObject *)observed {
    if (self = [super init]) {
        _observed = observed;
    }
    return self;
}

- (void)dealloc {
    @autoreleasepool {
        NSDictionary<NSString *, NSHashTable<NSObject *> *> *kvoinfos =  self.kvoInfoMap.copy;
        for (NSString *keyPath in kvoinfos) {
            // call original  IMP
            __xx_hook_orgin_function_removeObserver(_observed,@selector(removeObserver:forKeyPath:),self, keyPath);
        }
    }
}

- (NSMutableDictionary<NSString *,NSHashTable<NSObject *> *> *)kvoInfoMap {
    if (!_kvoInfoMap) {
        _kvoInfoMap = @{}.mutableCopy;
    }
    return _kvoInfoMap;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // dispatch to origina observers
    NSHashTable<NSObject *> *os = self.kvoInfoMap[keyPath];
    for (NSObject  *observer in os) {
        @try {
            [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        } @catch (NSException *exception) {
            NSString *reason = [NSString stringWithFormat:@"non fatal Error%@",[exception description]];
            [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
        }
    }
}

@end

@implementation NSObject (SafeKVO)

+ (void)registerClassPairMethodsInKVO {
    
    [self instanceSwizzleMethod:@selector(addObserver:forKeyPath:options:context:) replaceMethod:@selector(safe_addObserver:forKeyPath:options:context:)];
    
    [self instanceSwizzleMethod:@selector(removeObserver:forKeyPath:) replaceMethod:@selector(safe_removeObserver:forKeyPath:)];
}

- (void)safe_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    if (!self.kvoProxy) {
        @autoreleasepool {
            self.kvoProxy = [[XXKVOProxy alloc] initWithObserverd:self];
        }
    }
    
    NSHashTable<NSObject *> *os = self.kvoProxy.kvoInfoMap[keyPath];
    if (os.count == 0) {
        os = [[NSHashTable alloc] initWithOptions:(NSPointerFunctionsWeakMemory) capacity:0];
        [os addObject:observer];
        
        self.kvoProxy.kvoInfoMap[keyPath] = os;
        return;
    }
    
    if ([os containsObject:observer]) {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@, reason : KVO add Observer to many timers.",
                            [self class], NSStringFromSelector(@selector(addObserver:forKeyPath:options:context:))];
        
        [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
    } else {
        [os addObject:observer];
    }
}

- (void)safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    
    NSHashTable<NSObject *> *os = self.kvoProxy.kvoInfoMap[keyPath];
    
    if (os.count == 0) {
        NSString *reason = [NSString stringWithFormat:@"target is %@ method is %@, reason : KVO remove Observer to many times.",
                            [self class], NSStringFromSelector(@selector(removeObserver:forKeyPath:))];
        [MYSafeKitRecord recordFatalWithReason:reason errorType:(MYSafeKitShieldTypeKVO)];
        return;
    }
    
    [os removeObject:observer];
    
    if (os.count == 0) {
        [self.kvoProxy.kvoInfoMap removeObjectForKey:keyPath];
    }
}

- (void)setKvoProxy:(XXKVOProxy *)kvoProxy {
    objc_setAssociatedObject(self, @selector(kvoProxy), kvoProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XXKVOProxy *)kvoProxy {
    return objc_getAssociatedObject(self, @selector(kvoProxy));
}

@end
