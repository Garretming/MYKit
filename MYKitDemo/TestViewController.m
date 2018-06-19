//
//  TestViewController.m
//  MYKitDemo
//
//  Created by QMMac on 2018/6/19.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "TestViewController.h"
#import "XXNotificationObserver.h"
#import "NSNotificationCenter+SafeKit.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    XXNotificationObserver *_observer = [XXNotificationObserver new];
    [[NSNotificationCenter defaultCenter] addObserver:_observer selector:@selector(noti:) name:@"noti" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
