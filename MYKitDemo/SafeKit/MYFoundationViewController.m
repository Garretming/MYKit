//
//  MYFoundationViewController.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/31.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYFoundationViewController.h"

@interface MYFoundationViewController ()

@end

@implementation MYFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *value = nil;
    NSString *key = nil;
    //1、@[nil]
    NSArray *array0 = @[value];
    NSLog(@"array0:%@",array0);
    
    //2、objectAtIndex
    NSArray *array2 = @[@"1",@"2",@"3"];
    id objectAtIndex = [array2 objectAtIndex:4];
    array2[4];
    
    //3、objectsAtIndexes:
    NSArray *array3 = @[@"1",@"2",@"3"];
    NSArray *objectsAtIndexes = [array3 objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 2)]];
    NSLog(@"objectsAtIndexes:%@",objectsAtIndexes);
    
    //4、arrayByAddingObject
    [array3 arrayByAddingObject:nil];
    
    //5、indexOfObject
    NSArray *temp = [NSArray array];
    [array3 indexOfObject:@"B" inRange:NSMakeRange(0, 5)];
    
    //6、indexOfObjectIdenticalTo
    [array3 indexOfObjectIdenticalTo:@"B" inRange:NSMakeRange(0, 5)];
    
    //7、subarrayWithRange
    [array3 subarrayWithRange:NSMakeRange(0, 6)];
    
    //8、objectsAtIndexes
    [temp objectsAtIndexes:[NSIndexSet indexSetWithIndex:100]];
    
    [array3 objectAtIndexedSubscript:1000];
  
    //    NSMutableArray * mutableArray = [NSMutableArray new].safe;
    //    [mutableArray addObject:@"AA"];
    //    [mutableArray removeObjectAtIndex:5];
    //    [mutableArray addObjectsFromArray:nil];
    //    [mutableArray removeObject:nil inRange:NSMakeRange(0, 1)];
    //    [mutableArray removeObject:nil];
    //    [mutableArray removeObjectIdenticalTo:nil inRange:NSMakeRange(0, 1)];
    //    [mutableArray removeObjectsInArray:nil];
    //    [mutableArray setObject:nil atIndexedSubscript:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
