//
//  NSArray+Extension.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (CGFloat)getSum {
    return [[self valueForKeyPath:@"@sum.self"] floatValue];
}

- (CGFloat)getMax {
    return [[self valueForKeyPath:@"@max.self"] floatValue];
}

- (NSArray *)randomCopy {
    NSMutableArray *mutableArray = [self mutableCopy];
    NSUInteger count = [mutableArray count];
    if (count > 1) {
        for (NSUInteger i = count - 1; i > 0; --i) {
            [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
        }
    }
    return [mutableArray copy];
}

- (NSArray *)reversedArray {
    return [NSArray reversedArray:self];
}

+ (NSArray *)reversedArray:(NSArray *)array {
    // 从一个阵列容量初始化阵列
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:array.count];
    // 获取NSArray的逆序枚举器
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    return arrayTemp;
}

- (NSString *)arrayToJson {
    return [NSArray arrayToJson:self];
}

+ (NSString *)arrayToJson:(NSArray*)array {
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
