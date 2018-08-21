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
#import "UIView+FindSubView.h"

@interface MYViewController ()

@end

@implementation MYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *testView1 = [[UIView alloc] init];
    testView1.frame = CGRectMake((MYScreenWidth - 50)/2, 84, 100, 50);
    testView1.backgroundColor = [UIColor redColor];
    [testView1 setCornerRadii:25 roundingCorners:UIRectCornerAllCorners borderWidth:1.0f borderColor:[UIColor blueColor]];
    
    [self.view addSubview:testView1];
    
    UIView *testView2 = [[UIView alloc] init];
    testView2.frame = CGRectMake((MYScreenWidth - 50)/2, CGRectGetMaxY(testView1.frame) + 50, 100, 50);
    testView2.backgroundColor = [UIColor brownColor];
    [testView2 setCornerRadii:25 roundingCorners:UIRectCornerAllCorners borderWidth:1.0f borderColor:[UIColor blueColor]];
    
    [self.view addSubview:testView2];
    
    NSLog(@"两个view的共同父视图%@", [UIView findCommonSuperView:testView1 other:testView2]);
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
