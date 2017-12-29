//
//  NSCharacterSet+Addition.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSCharacterSet+Addition.h"

#define UNICHAR_MAX (1ull << (CHAR_BIT * sizeof(unichar))) - 1

@implementation NSCharacterSet (Addition)

- (NSSet *)toSet {
    NSData *data = [self bitmapRepresentation];
    uint8_t *ptr = (uint8_t *)[data bytes];
    NSMutableSet *set = [NSMutableSet set];
    // following from Apple's sample code
    for (unichar i = 0; i < UNICHAR_MAX; i++) {
        if (ptr[i >> 3] & (1u << (i & 7))) {
            [set addObject:[NSString stringWithCharacters:&i length:1]];
        }
    }
    return set;
}

@end
