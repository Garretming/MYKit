//
//  NSData+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/3/13.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "NSData+Addition.h"

@implementation NSData (Addition)

- (NSString *)APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

@end
