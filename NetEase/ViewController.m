//
//  ViewController.m
//  NetEase
//
//  Created by ihj on 15/9/4.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "ViewController.h"
#import "FMViewController.h"
#import "TopicViewController.h"
#import "VideoViewController.h"
#import "MediaContainViewController.h"
@interface ViewController ()
@property(strong, nonatomic) UITabBarController *mainController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabItems];

}

- (void) setupTabItems{
//    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"tabbar_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_news_highlight"]];
//    
//    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"视听" image:[UIImage imageNamed:@"tabbar_icon_media_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_media_highlight"]];
//    不能直接修改tabbar。
//    self.tabBar.items = @[item1,item2];
    
    TopicViewController *topicController = [[TopicViewController alloc] init];
    topicController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"新闻" image:[UIImage imageNamed:@"tabbar_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_news_highlight"]];
    

    MediaContainViewController *mediaController = [[MediaContainViewController alloc] init];
    
    mediaController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视听" image:[UIImage imageNamed:@"tabbar_icon_media_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_media_highlight"]];
    
    self.viewControllers = @[[self navigateVC:topicController],[self navigateVC:mediaController]];
}

- (UINavigationController *)navigateVC:(UIViewController *)controller{
    return [[UINavigationController alloc] initWithRootViewController:controller];
}


@end
