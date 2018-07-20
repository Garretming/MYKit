//
//  MYLabelViewController.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/20.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYLabelViewController.h"
#import "MYKitMacroHeader.h"
#import "UILabel+LimitLines.h"

@interface MYLabelViewController ()

@property (nonatomic, strong) UILabel *testLabel;

@end

@implementation MYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.frame = CGRectMake(10, 64, MYScreenWidth - 20, 200);
    testLabel.font = [UIFont systemFontOfSize:14.0f];
    testLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
//    testLabel.myLineSpacing = 10.0f;
//    [testLabel my_adjustTextToFitLines:3.0f];
    testLabel.numberOfLines = 0.0f;
    [testLabel adjustSizeAlignment:MYAdjustAlignmentCenter];
    
    [self.view addSubview:testLabel];
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
