//
//  _UIAlertController+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "_UIAlertController+Addition.h"

@implementation UIAlertController (Addition)

- (void)addButtonWithTitle:(NSString *)title block:(void(^)(void))block {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (block) {
            block();
        }
    }];
    [self addAction:action];
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(void(^)(void))block {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (block) {
            block();
        }
    }];
    [self addAction:action];
}

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(void(^)(void))block {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        if (block) {
            block();
        }
    }];
    [self addAction:action];
}

- (void)showInController:(UIViewController *)controller {
    [controller presentViewController:self animated:YES completion:nil];
}

@end
