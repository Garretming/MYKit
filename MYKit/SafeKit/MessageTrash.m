//
//  MessageTrash.m
//  Destruct
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "MessageTrash.h"
#import <objc/runtime.h>

@implementation MessageTrash

static void realizationFunction(id obj, SEL _cmd) {
    
}

//- (void)messageSource:(id)source unknowSelectorName:(NSString *)selector {
//    NSLog(@"-[%@ %@] unknow selector", source, selector);
//}

+ (instancetype)source:(Class)source selector:(SEL)selector {
    MessageTrash * mt = [MessageTrash new];
    BOOL add = class_addMethod(self, selector, (IMP)realizationFunction, "v@:");
    if (add) {
        NSLog(@"unrecognized selector: -[%@ %@]", source, NSStringFromSelector(selector));
    } else {
        NSLog(@"动态添加失败");
    }
    return mt;
}
@end
