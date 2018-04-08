//
//  ViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+CornerRadius.h"
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
#import "UIActionSheet+Addition.h"
#import "NSString+Extension.h"

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
    
    
    
    self.imageView.image = [self.imageView.image imageByRoundCornerRadius:100 scaleSize:self.imageView.bounds.size];
    
//    XXObject *object1 = [[XXObject alloc] init];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.frame = CGRectMake(100, 300, 50, 100);
    [yellowView addRedDotWithRadius:5 offsetX:0 offsetY:0];
    [yellowView showRedDot];

    [self.view addSubview:yellowView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20,CGRectGetMaxY(yellowView.frame),100,100)];
//    [button setTitle:@"测试文本" forState:UIControlStateNormal];
    
    UIImage *currentImage = [UIImage imageNamed:@"btn_kaibo_set_zhuantou_click"];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setImage:currentImage forState:UIControlStateNormal];
    [button setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:30];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [self.view addSubview:button];
    
    NSLog(@"判断UIView是否重叠-->%d",[self.view intersectsWithView:button]);
    
    /*
     * init array
     */
    self.arrayI = @[@"a", @"b", @"c", @"d"];
    
    self.arrayM = [self.arrayI mutableCopy];
    
    self.array0 = @[];
    
    self.singleObjectArrayI = @[@"a"];
    
    
    /*
     * overflow !
     */
    NSLog(@"self.array[5]: %@",self.arrayI[4]);
    NSLog(@"[self.array objectAtIndex:4]: %@",[self.arrayI objectAtIndex:4]);
    
    NSLog(@"[self.mArray objectAtIndex:5]: %@",self.arrayM[5]);
    NSLog(@"[self.mArray objectAtIndex:5]: %@",[self.arrayM objectAtIndex:5]);
    
    NSLog(@"self.emptyArray[5]: %@",self.array0[4]);
    NSLog(@"[self.emptyArray objectAtIndex:4]: %@",[self.array0 objectAtIndex:4]);
    
    NSLog(@"self.signalArray[5]: %@",self.singleObjectArrayI[4]);
    NSLog(@"[self.signalArray objectAtIndex:4]: %@",[self.singleObjectArrayI objectAtIndex:4]);
    
    
    NSMutableDictionary *testDict = [NSMutableDictionary dictionary];
    testDict[@"test"] = nil;
    
    NSLog(@"判读字典是否可以为空%@",testDict[@"test"]);
    
    
//    UIActionSheet *actionSheet = [UIActionSheet sheetWithTitle:nil];
//    [actionSheet setCancelButtonWithTitle:@"dadf" block:^{
//        NSLog(@"dadf");
//    }];
//
//    [actionSheet addButtonWithTitle:@"dadf" block:^{
//        NSLog(@"dadf");
//    }];
//
//    [actionSheet setDestructiveButtonWithTitle:@"取消禁言" block:^{
//        NSLog(@"取消禁言");
//    }];
//
//    [actionSheet showInController:self];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"asdfas" message:@"asdfasd" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    NSString *str = @"asdfkjlasdfkalsdfaslkdfas";
    
    NSLog(@"字符串%@",[str convertStrWith:3]);
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
