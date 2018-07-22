//
//  NSArray+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)

- (NSString *)arrayToJson {
    return [NSArray arrayToJson:self];
}

+ (NSString *)arrayToJson:(NSArray *)array {
    NSString *json = nil;
    NSError *error = nil;
    // 生成一个Foundation对象JSON数据
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:0
                                                     error:&error];
    if(!error) {
        json = [[NSString alloc] initWithData:data
                                     encoding:NSUTF8StringEncoding];
        return json;
    } else {
        // 返回主用户显示消息的错误
        return error.localizedDescription;
    }
}

@end
