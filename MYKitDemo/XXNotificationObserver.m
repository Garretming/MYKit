//
//  XXNotificationObserver.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/19.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "XXNotificationObserver.h"

@implementation XXNotificationObserver

- (void)noti:(NSNotification *)noti {
    NSLog(@"hello");
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
