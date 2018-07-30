//
//  Person.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/30.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)fireTimer:(NSTimer *)timer {
    NSLog(@"userinfo is %@",timer.userInfo);
}

- (void)fireTimer {
    NSLog(@"fire");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}

- (void)dealloc {
    NSLog(@"person dealloced");
}

- (void)sayHello {
    NSLog(@"person say hello");
}

@end
