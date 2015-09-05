//
//  MediaContainViewController.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "MediaContainViewController.h"
#import "VideoViewController.h"
#import "FMViewController.h"
#import "SegmentView.h"

@interface MediaContainViewController ()<SegmentViewDelegate>
@property(strong, nonatomic) SegmentView *segmentView;
@end

@implementation MediaContainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSegmentView];
    [self setupContent];
}

- (void)setupSegmentView{
    self.segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
    self.segmentView.delegate = self;
    self.navigationItem.titleView = self.segmentView;
}

- (void)setupContent{
    VideoViewController *videoViewController = [[VideoViewController alloc] init];
    [self addChildViewController:videoViewController];
    [self.view addSubview:videoViewController.view];
    
    FMViewController *audioViewCOntroller = [[FMViewController alloc] init];
    [self addChildViewController:audioViewCOntroller];
    audioViewCOntroller.view.hidden = YES;
    [self.view addSubview:audioViewCOntroller.view];
}


- (void)segmentView:(SegmentView *)view didClickAtIndex:(NSInteger)index{
    NSArray *contentView = [self.view subviews];
    
    [contentView enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         UIView *view = (UIView *)obj;
        if (idx == index) {
            view.hidden = NO;
        }else{
            view.hidden = YES;
        }
    }];
}
@end
