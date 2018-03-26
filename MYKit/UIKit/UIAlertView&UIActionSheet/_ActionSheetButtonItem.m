//
//  _ActionSheetButtonItem.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "_ActionSheetButtonItem.h"

@implementation _ActionSheetButtonItem

@synthesize label;
@synthesize action;

+ (instancetype)item {
    return [self new];
}

+ (instancetype)itemWithLabel:(NSString *)inLabel {
    _ActionSheetButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

+ (instancetype)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action {
    _ActionSheetButtonItem *newItem = [self itemWithLabel:inLabel];
    [newItem setAction:action];
    return newItem;
}

@end
