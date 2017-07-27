//
//  WBGlobalSettingViewController.m
//  FlowWindow
//
//  Created by buginux on 2017/7/27.
//  Copyright © 2017年 buginux. All rights reserved.
//

#import "WBGlobalSettingViewController.h"

@implementation WBGlobalSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
}

- (void)dismiss:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
