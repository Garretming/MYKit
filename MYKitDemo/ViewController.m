//
//  ViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Color.h"
#import "UIImage+Extension.h"
#import "UIImageView+CornerRadius.h"
#import "XXObject.h"
#import "UIView+RedDot.h"
#import "UIButton+ImageTitleStyle.h"
#import "UIView+FindSubView.h"
#import "UIImage+RoundedAvatar.h"
#import "UINavigationBar+Addition.h"
#import "UIActionSheet+Block.h"
#import "NSString+Extension.h"
#import "UIView+CustomBorder.h"
#import "UIView+CornerRadii.h"
#import "UIView+Style.h"
#import "NSString+SafeKit.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSArray *arrayI;
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (nonatomic, strong) NSArray *array0;
@property (nonatomic, strong) NSArray *singleObjectArrayI;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"asdfaskdljfakl;sdjfa";
    
    [str substringToIndex:90];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)testFoundationCategory {
    
}

- (void)testUIKitCategory {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
