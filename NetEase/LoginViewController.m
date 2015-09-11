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
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property(nonatomic,copy) NSArray *permissions;
@property (weak, nonatomic) IBOutlet UITextField *numberLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (strong, nonatomic) RACSignal *numberValidSignal;

@property (strong, nonatomic) RACSignal *passwordVaildSignal;

@property (strong, nonatomic) RACSignal *validLoginSignal;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindEvent];
    [self grantPremission];
}

//控件绑定数据流
- (void) bindEvent{
//    [self.numberLabel.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"text --- %@",x);
//    }];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"button clicked");
    }];
    
    
    self.numberValidSignal = [[self.numberLabel.rac_textSignal
      map:^id(NSString * text) {
          return @(text.length);
    }]
    filter:^BOOL(NSNumber * number) {
        return [number integerValue] > 1;
    }];
    
    self.passwordVaildSignal = [[self.passwordLabel.rac_textSignal map:^id(id value) {
        NSString *text = (NSString *)value;
        return @(text.length);
    }] filter:^BOOL(NSNumber *value) {
        return [value integerValue] > 1;
    }];
    
   [[RACSignal combineLatest:@[self.numberValidSignal,self.passwordVaildSignal] reduce:^id(id value1, id value2){
        BOOL b1 = [value1 boolValue];
        BOOL b2 = [value2 boolValue];
        return  @(b1 && b2);
    }]
    subscribeNext:^(NSNumber *number) {
        NSLog(@"-----");
    }];

}



- (void)grantPremission{
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:qqAppID andDelegate:self];
    self.permissions = @[@"get_user_info", @"add_share"];
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
