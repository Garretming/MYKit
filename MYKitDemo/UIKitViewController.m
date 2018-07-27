//
//  UIKitViewController.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIKitViewController.h"
#import "MYKitMacroHeader.h"

@interface UIKitViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation UIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIKit";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.dataSource addObject:@"*UIKit之AlertController*-MYAlertViewController"];
    [self.dataSource addObject:@"*UIKit之NavigationBar*-MYNavigationBarViewController"];
    [self.dataSource addObject:@"*UIKit之TextField*-MYTextFieldViewController"];
    [self.dataSource addObject:@"*UIKit之Label*-MYLabelViewController"];
    [self.dataSource addObject:@"*UIKit之Button*-MYButtonViewController"];
    [self.dataSource addObject:@"*UIKit之Color*-MYColorViewController"];
    [self.dataSource addObject:@"*UIKit之Image*-MYImageViewController"];
    [self.dataSource addObject:@"*UIKit之View*-MYViewController"];
    [self.dataSource addObject:@"*UIWebView实战*-MYWebViewController"];
    [self.dataSource addObject:@"自定义UISwitch-MYAMViralSwitchViewController"];
    [self.dataSource addObject:@"CollectionDynamicCell-MYAutomaticallyCollectionViewCellViewController"];
    [self.dataSource addObject:@"自定义导航栏-MYCustomNavigationBarViewController"];

    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    NSString *className = [[title componentsSeparatedByString:@"-"] lastObject];
    
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    viewController.title = [[title componentsSeparatedByString:@"-"] firstObject];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MYScreenWidth, MYScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end