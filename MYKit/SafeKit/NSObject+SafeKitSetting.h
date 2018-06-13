//
//  NSObject+SafeKitSetting.h
//  QMSafeKit
//
//  Created by David on 2018/3/29.
//  Copyright © 2018年 David. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SF_APP_Version(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

@interface NSObject (SafeKitSetting)

/**
 *  显示提示框
 */
- (void)safeKit_showAlterWithMessage:(NSString *)messsage;


#pragma mark - error mesasge

//数组越界
- (void)sf_showObjectAtIndexError_Array;
//添加空数据
- (void)sf_showAddNilData_Array;
//数组构造函数空数据
- (void)sf_constructor_Array;

//字典越界
- (void)sf_showObjectAtIndexError_Dictionary;
//添加空数据
- (void)sf_showAddNilData_Dictionary;

//string-越界
- (void)sf_showObjectAtIndexError_String;
//string-添加空数据
- (void)sf_showAddNilData_String;

//NSMutableAttributedString-越界
- (void)sf_showObjectAtIndexError_AttributedString;
//NSMutableAttributedString-添加空数据
- (void)sf_showAddNilData_String_AttributedString;

//number-添加空数据
- (void)sf_showAddNilData_Number;

//observer 多次添加
- (void)sf_showAddMoreObserver;
//observer 多次删除
- (void)sf_showRemoveMoreObserver;

@end
