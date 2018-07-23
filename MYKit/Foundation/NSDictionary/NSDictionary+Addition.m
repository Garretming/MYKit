//
//  NSDictionary+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

- (NSString *)JSONString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSArray<NSString *> *)arrayStringAscending {
    return [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]]) {
            return [obj1 compare:obj2];
        }
        return NSOrderedSame;
    }];
}

@end
