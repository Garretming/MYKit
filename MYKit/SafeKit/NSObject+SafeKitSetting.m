//
//  NSObject+SafeKitSetting.m
//  QMSafeKit
//
//  Created by David on 2018/3/29.
//  Copyright © 2018年 David. All rights reserved.
//

#import "NSObject+SafeKitSetting.h"
#import <UIKit/UIKit.h>
#import "UIApplication+SafeKit.h"

#define SafeKit_margin_string @"========================SafeKit Log=========================="
#define SafeKit_tipString(string) [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n",SafeKit_margin_string, string, SafeKit_margin_string]
#define SafeKit_NSAssert(string) NSAssert(NO, SafeKit_tipString(string))

#define Error_array_index @"数组-数据越界"
#define Error_array_nil @"数组-添加空数据"
#define Error_array_constructor_nil @"数组-构造函数空数据"
#define Error_dict_index @"字典-数据越界"
#define Error_dict_nil @"字典-添加空数据"
#define Error_string_index @"字符串-数据越界"
#define Error_string_nil @"字符串-添加空数据"
#define Error_attributedString_index @"attributedString字符串-数据越界"
#define Error_attributedString_nil @"attributedString字符串-添加空数据"
#define Error_number_nil @"number-添加空数据"
#define Error_add_more_abserver @"添加多次观察者"
#define Error_remove_more_abserver @"删除多次观察者"
#define Error_UnknowSelector @"发送未知的方法地址"


@implementation NSObject (SafeKitSetting)

- (void)safeKit_showAlterWithMessage:(NSString *)messsage {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:messsage
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (NSString *)getErrorMessageWithTipString:(NSString *)tipString {
    NSString *contentString = tipString;
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    if (callStackSymbolsArr != nil) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:callStackSymbolsArr];
        NSString *ErrorString = [mutableArray componentsJoinedByString:@"\n"];//分隔符逗号
        contentString = [NSString stringWithFormat:@"%@\n%@", tipString, ErrorString];
    }
    
    return contentString;
}

- (void)showErrorMessage:(NSString *)message {
    //错误堆栈信息
    NSString *string = [self getErrorMessageWithTipString:message];
    
    if ([UIApplication sharedApplication].safeKit_isTestEnvironment) {
        [self safeKit_showAlterWithMessage:string];
    }
    __block NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //将错误信息放在字典里，用通知的形式发送出去
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *messageTip = message;
        if (messageTip == nil) {
            messageTip = [[NSString alloc] init];
        }
        if (callStackSymbolsArr == nil) {
            callStackSymbolsArr = [[NSArray alloc] init];
        }
        NSDictionary *messageDict = @{@"message": messageTip, @"stackArray": callStackSymbolsArr};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QMSafeKitNotification" object:messageDict userInfo:nil];
    });
}

- (void)sf_showObjectAtIndexError_Array {
    SafeKit_NSAssert(Error_array_index);
    [self showErrorMessage:Error_array_index];
}

- (void)sf_showAddNilData_Array {
    SafeKit_NSAssert(Error_array_nil);
    [self showErrorMessage:Error_array_index];
}

- (void)sf_constructor_Array {
    SafeKit_NSAssert(Error_array_constructor_nil);
    [self showErrorMessage:Error_array_constructor_nil];
}

- (void)sf_showObjectAtIndexError_Dictionary {
    SafeKit_NSAssert(Error_dict_index);
    [self showErrorMessage:Error_dict_index];
}

- (void)sf_showAddNilData_Dictionary {
    SafeKit_NSAssert(Error_dict_nil);
    [self showErrorMessage:Error_dict_nil];
}


- (void)sf_showObjectAtIndexError_String {
    SafeKit_NSAssert(Error_string_index);
    [self showErrorMessage:Error_string_index];
}

- (void)sf_showAddNilData_String {
    SafeKit_NSAssert( Error_string_nil);
    [self showErrorMessage:Error_string_nil];
}

- (void)sf_showObjectAtIndexError_AttributedString {
    SafeKit_NSAssert( Error_attributedString_index);
    [self showErrorMessage:Error_attributedString_index];
}

- (void)sf_showAddNilData_String_AttributedString {
    SafeKit_NSAssert( Error_attributedString_nil);
    [self showErrorMessage:Error_attributedString_nil];
}

- (void)sf_showAddNilData_Number {
    SafeKit_NSAssert( Error_number_nil);
    [self showErrorMessage:Error_number_nil];
}

- (void)sf_showAddMoreObserver {
    SafeKit_NSAssert( Error_add_more_abserver);
    [self showErrorMessage:Error_add_more_abserver];
}

- (void)sf_showRemoveMoreObserver {
    SafeKit_NSAssert( Error_remove_more_abserver);
    [self showErrorMessage:Error_remove_more_abserver];
}

- (void)sf_showUnknowSelectorError {
    SafeKit_NSAssert( Error_UnknowSelector);
    [self showErrorMessage:Error_UnknowSelector];
}

@end
