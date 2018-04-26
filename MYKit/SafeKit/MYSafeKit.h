//
//  MYSafeKit.h
//  MYKitDemo
//
//  Created by QMMac on 2018/4/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#ifndef MYSafeKit_h
#define MYSafeKit_h

//通知
#define MYSafeKitNotification @"MYSafeKitNotification"

#define SafeKit_margin_string @"========================SafeKit Log=========================="
#define SafeKit_tipString(string) [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n",SafeKit_margin_string, string, SafeKit_margin_string]
#define SafeKit_NSAssert(string) NSAssert(NO, SafeKit_tipString(string))

#define Error_array_index @"数组-数据越界"
#define Error_array_nil @"数组-添加空数据"
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

#import "MessageTrash.h"
#import "UIApplication+SafeKit.h"
#import "NSObject+SafeKitSetting.h"
#import "NSArray+SafeKit.h"
#import "NSDictionary+SafeKit.h"
#import "NSMutableArray+SafeKit.h"
#import "NSMutableAttributedString+SafeKit.h"
#import "NSMutableDictionary+SafeKit.h"
#import "NSMutableString+SafeKit.h"
#import "NSNumber+SafeKit.h"
#import "NSObject+SafeObserver.h"
#import "NSString+SafeKit.h"

#endif /* MYSafeKit_h */
