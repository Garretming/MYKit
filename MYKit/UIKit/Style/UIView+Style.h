//
//  UIView+FunctionExtension.h
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - StyleFormat
@interface UIView (Style)

/// 共享样式
@property (nonatomic, copy) void (^ _Nullable shareStyle) (id _Nullable sourceView);

/// 共享样式会有循环引用问题
- (void)shareStyle:(void(^_Nullable)(id _Nullable sourceView))share uniqueStyle:(void(^_Nullable)(id _Nullable sourceView))unique;

@end

