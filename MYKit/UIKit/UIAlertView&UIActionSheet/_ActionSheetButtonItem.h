//
//  _ActionSheetButtonItem.h
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _ActionSheetButtonItem : NSObject {
    NSString *label;
    void (^action)();
}

@property (nonatomic, strong) NSString *label;
@property (nonatomic, copy) void (^action)();

+ (instancetype)item;
+ (instancetype)itemWithLabel:(NSString *)inLabel;
+ (instancetype)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action;

@end
