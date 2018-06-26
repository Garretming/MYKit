//
//  ViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "ViewController.h"
#import "XXShield.h"
#import "TestViewController.h"
#import "MYSafeKit.h"
#import "NSArray+Safe.h"
#import "NSMutableArray+Safe.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MYSafeKit registerSafeKitShieldWithAbility:MYSafeKitShieldTypeContainer];
//    NSArray * array = @[@"A",@"B"];

//    [array objectAtIndex:0];
//    [array arrayByAddingObject:nil];
//    [array indexOfObject:nil inRange:NSMakeRange(0, 2)];
//    [array indexOfObjectIdenticalTo:@"B" inRange:NSMakeRange(0, 2)];
//    [array subarrayWithRange:NSMakeRange(0, 1)];
//    [array objectsAtIndexes:[NSIndexSet indexSetWithIndex:10]];
//    [array objectAtIndexedSubscript:100];
//    [array arrayByAddingObjectsFromArray:nil];
//    [array componentsJoinedByString:nil];
//    [array containsObject:nil];
//    [array descriptionWithLocale:nil];
//    [array descriptionWithLocale:nil indent:1000];
//    [array firstObjectCommonWithArray:nil];
//    [array indexOfObject:nil];
//    [array isEqualToArray:nil];
//    [array indexOfObjectIdenticalTo:nil];

    
    NSMutableArray * mutableArray = [NSMutableArray new];
    [mutableArray addObject:nil];
    [mutableArray removeObjectAtIndex:5];
    [mutableArray addObjectsFromArray:nil];
    [mutableArray removeObject:nil inRange:NSMakeRange(0, 1)];
    [mutableArray removeObject:nil];
    [mutableArray removeObjectIdenticalTo:nil inRange:NSMakeRange(0, 1)];
    [mutableArray removeObjectsInArray:nil];
    [mutableArray setObject:nil atIndexedSubscript:0];
    
    
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
    
//    NSString *str = @"akdaldllad".safe;
//
//    [str substringFromIndex:200];
//    [str substringToIndex:200];
//    [str characterAtIndex:213];
//    [str substringWithRange:NSMakeRange(0, 200)];
    
//    [NSObject safeGuardUnrecognizedSelector];
//
//    XXObject *object = [[XXObject alloc] init];
//    [object performSelector:@selector(addads) withObject:nil];
//    [XXObject performSelector:@selector(addads) withObject:nil];
    
//    [NSNotificationCenter safeGuardNotificationSelector];
    
//    [NSNull safeGuardNullSelector];
//    NSString *null = (NSString *)[NSNull null];
//    NSString *result = [null stringByAppendingString:@"fafa"];
    
//    NSNumber *null = (NSNumber *)[NSNull null];
//    BOOL result = [null boolValue];
    
//    NSArray<NSString *> *null = (NSArray *)[NSNull null];
//    NSArray *result = [null arrayByAddingObjectsFromArray:@[@"xx"]];
    
//    NSDictionary<NSString *, NSString *> *null = (NSDictionary *)[NSNull null];
//    NSArray *allKeys = [null allKeys];
//    NSArray *allValues = [null allValues];
//
//    NSLog(@"%d---%d", [allKeys isEqual:@[]], [allValues isEqual:@[]]);
}

- (IBAction)testNotification {
    
    TestViewController *test = [[TestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
