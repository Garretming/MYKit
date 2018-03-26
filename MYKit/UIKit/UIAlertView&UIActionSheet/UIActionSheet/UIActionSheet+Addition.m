//
//  UIActionSheet+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIActionSheet+Addition.h"
#import "_ActionSheetButtonItem.h"
#import <objc/runtime.h>

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
static NSString *RI_BUTTON_ASS_KEY = @"RI_BUTTON_ASS_KEY_ACTIONSHEET";
static NSString *RI_DISMISSAL_ACTION_KEY = @"RI_DISMISSAL_ACTION_KEY_ACTIONSHEET";

@implementation UIActionSheet (Addition)

+ (id)sheetWithTitle:(NSString *)title {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && IS_IPHONE) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        return alertController;
    } else {
        return [[UIActionSheet alloc] initWithTitle:title cancelButtonItem:nil destructiveButtonItem:nil otherButtonItems:nil];
    }
}

- (instancetype)initWithTitle:(NSString *)inTitle
             cancelButtonItem:(_ActionSheetButtonItem *)inCancelButtonItem
        destructiveButtonItem:(_ActionSheetButtonItem *)inDestructiveItem
             otherButtonItems:(_ActionSheetButtonItem *)inOtherButtonItems, ... {
     return [self initWithTitle:inTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
}

- (NSInteger)addButtonItem:(_ActionSheetButtonItem *)item {
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
    
    NSInteger buttonIndex = [self addButtonWithTitle:item.label];
    [buttonsArray addObject:item];
    
    return buttonIndex;
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
    _ActionSheetButtonItem *item = [_ActionSheetButtonItem itemWithLabel:inLabel action:block];
    NSInteger index = [self addButtonItem:item];
    [self setDestructiveButtonIndex:index];
}

- (void)setDismissalAction:(void(^)())dismissalAction {
    objc_setAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY, dismissalAction, OBJC_ASSOCIATION_COPY);
}

- (void(^)())dismissalAction {
    return objc_getAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // Action sheets pass back -1 when they're cleared for some reason other than a button being
    // pressed.
    if (buttonIndex >= 0) {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY);
        _ActionSheetButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.action)
            item.action();
    }
    
    if (self.dismissalAction) self.dismissalAction();
    
    objc_setAssociatedObject(self, (__bridge const void *)RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)RI_DISMISSAL_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    
}

- (void)showInController:(UIViewController *)controller {
    [self showInView:controller.view];
}

@end
