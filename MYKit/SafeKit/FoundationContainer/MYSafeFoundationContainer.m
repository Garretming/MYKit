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
#import "NSDictionary+Safe.h"
#import "NSMutableDictionary+Safe.h"

@interface MYSafeFoundationContainer ()

@property (nonatomic, strong) NSArray *tempArray;

@end

@implementation MYSafeFoundationContainer

+ (void)safeGuardContainersSelector {
    
    [NSArray registerClassPairMethodsInNSArray];
    [NSMutableArray registerClassPairMethodsInNSMutableArray];
    
    [NSDictionary registerClassPairMethodsInDictionary];
    [NSMutableDictionary registerClassPairMethodsInMutableDictionary];
}

@end
