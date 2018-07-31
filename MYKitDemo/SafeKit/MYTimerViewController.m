//
//  MYTimerViewController.m
//  MYKitDemo
//
//  Created by QMMac on 2018/7/30.
//  Copyright © 2018 com.51fanxing. All rights reserved.
//

#import "MYTimerViewController.h"
#import "Person.h"
#import "NSTimer+Safe.h"

@interface MYTimerViewController ()

@end

@implementation MYTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testTimer];
}

- (void)testTimer {

    // target会被runloop持有 造成隐式的内存泄漏 开启防护之后会自动注销timer
    [NSTimer scheduledTimerWithTimeInterval:1 target:[Person new] selector:@selector(fireTimer:) userInfo:@{@"hah":@"jaj"} repeats:YES];
    
}

@end
