//
//  UIAlertView+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIAlertView+Addition.h"
#import "_ActionSheetButtonItem.h"
#import <objc/runtime.h>

static NSString *RI_BUTTON_ASS_KEY = @"RI_BUTTON_ASS_KEY_ALERTVIEW";

@implementation UIAlertView (Addition)

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        return alert;
    } else {
        return [[UIAlertView alloc] initWithTitle:title message:message cancelButtonItem:nil otherButtonItems:nil];
    }
}

- (id)initWithTitle:(NSString *)inTitle
            message:(NSString *)inMessage
   cancelButtonItem:(_ActionSheetButtonItem *)inCancelButtonItem
   otherButtonItems:(_ActionSheetButtonItem *)inOtherButtonItems, ... {
    return [self initWithTitle:inTitle message:inMessage delegate:self cancelButtonTitle:inCancelButtonItem.label otherButtonTitles:nil];
}

- (NSInteger)addButtonItem:(_ActionSheetButtonItem *)item {
    NSInteger buttonIndex = [self addButtonWithTitle:item.label];
    [[self buttonItems] addObject:item];
    
    if (![self delegate]) {
        [self setDelegate:self];
    }
    
    return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // If the button index is -1 it means we were dismissed with no selection
    if (buttonIndex >= 0) {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
        _ActionSheetButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action();
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)buttonItems {
    NSMutableArray *buttonItems = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
    if (!buttonItems) {
        buttonItems = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, buttonItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return buttonItems;
}

- (void)addButtonWithTitle:(NSString *)inLabel block:(void(^)(void))block {
    _ActionSheetButtonItem *item = [_ActionSheetButtonItem itemWithLabel:inLabel action:block];
    [self addButtonItem:item];
}

- (void)setCancelButtonWithTitle:(NSString *)inLabel block:(void(^)(void))block {
    _ActionSheetButtonItem *item = [_ActionSheetButtonItem itemWithLabel:inLabel action:block];
    NSInteger index = [self addButtonItem:item];
    [self setCancelButtonIndex:index];
}

- (void)setDestructiveButtonWithTitle:(NSString *)inLabel block:(void(^)(void))block {
    
}

- (void)showInController:(UIViewController *)controller {
    [self show];
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    
}

@end
