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
#import "UILabel+AutomaticWriting.h"
#import "UILabel+LineSpacing.h"

@interface MYLabelViewController ()

@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) UILabel *writingLabel;

@end

@implementation MYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UILabel registerLineSpacingSelector];

    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.frame = CGRectMake(10, 84, MYScreenWidth - 20, 100);
    testLabel.font = [UIFont systemFontOfSize:14.0f];
    testLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    testLabel.numberOfLines = 0.0f;
    testLabel.lineSpace = 10.0f;
    [self.view addSubview:testLabel];
    _testLabel = testLabel;
    
    // 自动书写
    [self automaticWriting];
}

- (void)automaticWriting {
    
    UILabel *writingLabel = [[UILabel alloc] init];
    writingLabel.frame = CGRectMake(10, CGRectGetMaxY(self.testLabel.frame) + 50, MYScreenWidth - 20, 100);
    writingLabel.backgroundColor = [UIColor redColor];
    writingLabel.font = [UIFont systemFontOfSize:14.0f];
    writingLabel.textAlignment = NSTextAlignmentCenter;
    writingLabel.textColor = [UIColor blueColor];
    [self.view addSubview:writingLabel];
    _writingLabel = writingLabel;
    
    UIButton *automaticWritingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    automaticWritingButton.frame = CGRectMake((MYScreenWidth - 150)/2, CGRectGetMaxY(writingLabel.frame) + 50, 150, 50);
    [automaticWritingButton setTitle:@"automaticWriting" forState:UIControlStateNormal];
    [automaticWritingButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [automaticWritingButton addTarget:self action:@selector(automaticWriting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:automaticWritingButton];
}

- (void)automaticWriting:(UIButton *)sender {
    
    [self.writingLabel setText:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试" automaticWritingAnimationWithBlinkingMode:UILabelAWBlinkingModeWhenFinishShowing];
}

@end
