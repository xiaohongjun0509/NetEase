//
//  ViewController.m
//  NetEase
//
//  Created by ihj on 15/9/4.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong, nonatomic) UITabBarController *mainController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainController = [[UITabBarController alloc] init];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
