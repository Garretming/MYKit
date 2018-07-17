//
//  MYTextFieldViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2018/7/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTextFieldViewController.h"
#import "MYKitMacroHeader.h"
#import "UITextField+Shake.h"

@interface MYTextFieldViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation MYTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake((MYScreenWidth - 100)/2, 150, 100, 50);
    [textField.layer setBorderWidth:2];
    [textField.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.view addSubview:textField];
    _textField = textField;
    
    UIButton *actionSheetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    actionSheetButton.frame = CGRectMake((MYScreenWidth - 150)/2, CGRectGetMaxY(textField.frame) + 50, 150, 50);
    [actionSheetButton setTitle:@"showActionSheet" forState:UIControlStateNormal];
    [actionSheetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [actionSheetButton addTarget:self action:@selector(actionShake:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:actionSheetButton];
}

- (IBAction)actionShake:(id)sender {
    
    [self.textField shake];
}


@end
