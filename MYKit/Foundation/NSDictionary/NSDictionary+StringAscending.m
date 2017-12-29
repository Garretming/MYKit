//
//  NSDictionary+StringAscending.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSDictionary+StringAscending.h"

@implementation NSDictionary (StringAscending)

- (NSArray<NSString *> *)arrayStringAscending {
    return [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]]) {
            return [obj1 compare:obj2];
        }
        return NSOrderedSame;
    }];
}

@end
