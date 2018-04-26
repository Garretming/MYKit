//
//  MessageTrash.m
//  Destruct
//
//  Created by LiChunYang on 16/4/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "MessageTrash.h"
#import <objc/runtime.h>

@implementation MessageTrash

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)realizationFunction, "@@:");
    return YES;
}

id realizationFunction(id obj, SEL _cmd) {
    NSString * selName = NSStringFromSelector(_cmd);
    if (![selName isEqualToString:@"encodeWithOSLogCoder:options:maxLength:"]) {
        NSLog(@"%@", selName);
    }
    return nil;
}

@end
