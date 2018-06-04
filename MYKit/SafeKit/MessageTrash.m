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

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    class_addMethod([self class], sel, (IMP)realizationFunction, "@@:");
//    return YES;
//}
//
//id realizationFunction(id obj, SEL _cmd) {
//    NSString * selName = NSStringFromSelector(_cmd);
//    if (![selName isEqualToString:@"encodeWithOSLogCoder:options:maxLength:"]) {
//        NSLog(@"%@", selName);
//    }
//    return nil;
//}

- (void)messageSource:(id)source unknowSelectorName:(NSString *)selector {
    NSLog(@"%@: unknow selector:%@", source, selector);
}

@end
