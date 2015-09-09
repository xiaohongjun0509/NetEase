//
//  LoginViewController.m
//  NetEase
//
//  Created by xhj on 15/9/6.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "LoginViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>

#import <ReactiveCocoa.h>

static NSString * const qqAppID = @"1104847296";

static NSString * const qqAppKey = @"2Zb8Y6W9KaE657nK";

@interface LoginViewController ()<TencentSessionDelegate>
- (IBAction)qqLogin:(id)sender;
@property (nonatomic,strong) TencentOAuth *tencentOAuth;

@property(nonatomic,copy) NSArray *permissions;
@property (weak, nonatomic) IBOutlet UITextField *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:qqAppID andDelegate:self];
    self.permissions = @[@"get_user_info", @"add_share"];
    [self.numberLabel.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"text --- %@",x);
    }];
}

//登陆成功
-(void)tencentDidLogin{
    NSLog(@"%@",self.tencentOAuth.accessToken);
}

//登陆失败。没有登陆
- (void)tencentDidNotLogin:(BOOL)cancelled{
    
}

- (void)tencentDidNotNetWork{
    
}
//这里要异步登陆。
- (IBAction)qqLogin:(id)sender {
//  通过这句话来实现登陆。
//    dispatch_async(dispatch_queue_t queue, <#^(void)block#>)
    
    [self.tencentOAuth authorize:_permissions inSafari:NO];
}
@end
