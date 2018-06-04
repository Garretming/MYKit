//
//  NSObject+Message.m
//  A
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSObject+UnknowMessage.h"
#import "MessageTrash.h"
#import <objc/message.h>

@implementation NSObject (UnknowMessage)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSString * selString = NSStringFromSelector(anInvocation.selector);
    NSString * clsString = NSStringFromClass([self class]);
    MessageTrash * mt = [MessageTrash new];
    [anInvocation setTarget:mt];
    [anInvocation setSelector:@selector(messageSource:unknowSelectorName:)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types-discards-qualifiers"
    [anInvocation setArgument:&clsString atIndex:2];
    [anInvocation setArgument:&selString atIndex:3];
    [anInvocation invokeWithTarget:mt];
#pragma clang diagnostic pop
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"%@--%@", self, NSStringFromSelector(aSelector));
    return [NSMethodSignature signatureWithObjCTypes:"v@:@@"];
}
#pragma clang diagnostic pop

//- (void)doesNotRecognizeSelector:(SEL)aSelector {
//    
//}

@end
