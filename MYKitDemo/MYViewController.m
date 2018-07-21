//
//  MYViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/7/21.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYViewController.h"
#import "MYKitMacroHeader.h"
#import "UIView+CornerRadii.h"

@interface MYViewController ()

@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *testView = [[UIView alloc] init];
    testView.frame = CGRectMake((MYScreenWidth - 50)/2, 84, 50, 50);
    testView.backgroundColor = [UIColor redColor];
    [testView setCornerRadii:25 roundingCorners:UIRectCornerAllCorners borderWidth:1.0f borderColor:[UIColor blueColor]];
    [self.view addSubview:testView];
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
