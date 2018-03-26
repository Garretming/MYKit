//
//  UIActionSheet+Addition.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "_UIAlertController+Addition.h"

@interface UIActionSheet (Addition) <UIActionSheetDelegate, CustomAlertControllerDelegate>

+ (id)sheetWithTitle:(NSString *)title;

@end
