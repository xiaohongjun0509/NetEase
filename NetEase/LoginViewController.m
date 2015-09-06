//
//  LoginViewController.m
//  NetEase
//
//  Created by xhj on 15/9/6.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "LoginViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>



static NSString * const qqAppID = @"1104847296";

static NSString * const qqAppKey = @"2Zb8Y6W9KaE657nK";

@interface LoginViewController ()<TencentSessionDelegate>
- (IBAction)qqLogin:(id)sender;
@property (nonatomic,strong) TencentOAuth *tencentOAuth;

@property(nonatomic,copy) NSArray *permissions;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:qqAppID andDelegate:self];
    self.permissions = @[@"get_user_info", @"add_share"];
}

-(void)tencentDidLogin{

}


- (void)tencentDidNotLogin:(BOOL)cancelled{
    
}

- (void)tencentDidNotNetWork{
    
}
- (IBAction)qqLogin:(id)sender {
    [self.tencentOAuth authorize:_permissions inSafari:NO];
}
@end
