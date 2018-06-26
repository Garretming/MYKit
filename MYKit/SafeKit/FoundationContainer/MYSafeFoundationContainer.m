//
//  MYSafeFoundationContainer.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/26.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYSafeFoundationContainer.h"
#import "NSArray+Safe.h"
#import "NSMutableArray+Safe.h"

@interface MYSafeFoundationContainer ()

@property (nonatomic, strong) NSArray *tempArray;

@end

@implementation MYSafeFoundationContainer

+ (void)safeGuardContainersSelector {
    
    [self registerClassPairMethodsInNSArray];
    [self registerClassPairMethodsInNSMutableArray];
}

+ (void)registerClassPairMethodsInNSArray {
    
    [NSArray registerClassPairMethodsInNSArray];
}

+ (void)registerClassPairMethodsInNSMutableArray {
    
    [NSMutableArray registerClassPairMethodsInNSMutableArray];
}

@end
