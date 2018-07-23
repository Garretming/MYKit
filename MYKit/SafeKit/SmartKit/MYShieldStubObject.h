//
//  MYShieldStubObject.h
//  XXShield
//
//  Created by nero on 2017/1/19.
//  Copyright © 2017年 XXShield. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYShieldStubObject : NSObject

- (instancetype)init __unavailable;

+ (MYShieldStubObject *)shareInstance;

- (BOOL)addFunc:(SEL)sel;

+ (BOOL)addClassFunc:(SEL)sel;

@end
