//
//  ViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "ViewController.h"
#import "XXShield.h"
#import "NSString+SafeKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSArray * array = @[@"A", @"B", @"C"].safe;
//
//    [array objectAtIndex:0];
//    [array arrayByAddingObject:nil];
//    [array indexOfObject:@"B" inRange:NSMakeRange(0, 2)];
//    [array indexOfObjectIdenticalTo:@"B" inRange:NSMakeRange(0, 2)];
//    [array subarrayWithRange:NSMakeRange(0, 1)];
//    [array objectsAtIndexes:[NSIndexSet indexSetWithIndex:10]];
//    [array objectAtIndexedSubscript:1000];
//
//
//    [array arrayByAddingObjectsFromArray:nil];
//    [array componentsJoinedByString:nil];
//    [array containsObject:nil];
//    [array descriptionWithLocale:nil];
//    [array descriptionWithLocale:nil indent:1000];
//    [array firstObjectCommonWithArray:nil];
//    [array indexOfObject:nil];
//    [array isEqualToArray:nil];
//    [array indexOfObjectIdenticalTo:nil];
//
    
//    NSMutableArray * mutableArray = [NSMutableArray new].safe;
//    [mutableArray addObject:@"AA"];
//    [mutableArray removeObjectAtIndex:5];
//    [mutableArray addObjectsFromArray:nil];
//    [mutableArray removeObject:nil inRange:NSMakeRange(0, 1)];
//    [mutableArray removeObject:nil];
//    [mutableArray removeObjectIdenticalTo:nil inRange:NSMakeRange(0, 1)];
//    [mutableArray removeObjectsInArray:nil];
//    [mutableArray setObject:nil atIndexedSubscript:0];
    
//    NSSet * set = [NSSet set].safe;
//    [set anyObject];
//    [set containsObject:nil];
//    [set descriptionWithLocale:nil];
//    [set intersectsSet:nil];
//    [set isEqualToSet:nil];
//    [set isSubsetOfSet:nil];
//    [set setByAddingObject:nil];
//    id a = [set setByAddingObjectsFromSet:nil];
//    id b = [set setByAddingObjectsFromArray:nil];

//    NSMutableSet * mutableSet = [NSMutableSet set].safe;
//    [mutableSet addObject:nil];
//    [mutableSet addObjectsFromArray:nil];
//    [mutableSet intersectSet:nil];
//    [mutableSet minusSet:nil];
//
    
//    NSPointerArray * pointerArray = [NSPointerArray weakObjectsPointerArray].safe;
//    [pointerArray pointerAtIndex:1000];
//    [pointerArray removePointerAtIndex:10000];
    
    
//    NSHashTable * hashTable = [NSHashTable hashTableWithOptions:(NSPointerFunctionsWeakMemory)];
//    NSLog(@"%@", hashTable);
//    [hashTable addObject:nil];
//    NSLog(@"%@", hashTable);
//    NSObject *obj = [NSObject new];
//    __weak NSObject *obj1 =obj;
//    [hashTable addObject:obj1];
//    NSLog(@"%@", hashTable);
//    [hashTable removeObject:[UIViewController new]];
//    
//    NSMapTable * mapTable = [NSMapTable weakToWeakObjectsMapTable];
//    id a = [mapTable objectForKey:nil];
//    [mapTable removeObjectForKey:nil];
//    [mapTable setObject:nil forKey:nil];
//
    
    NSString *str = @"akdaldllad".safe;

    [str substringFromIndex:200];
    [str substringToIndex:200];
    [str characterAtIndex:213];
    [str substringWithRange:NSMakeRange(0, 200)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
