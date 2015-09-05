//
//  VideoViewController.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "VideoViewController.h"

#import "Common.h"

#import "VideoContentModel.h"
#import "VideoNewsModel.h"
#import "VideoTopicModel.h"
#import "VideoNewsCell.h"

#import <AVFoundation/AVFoundation.h>

static NSString *const requestUrl = @"http://c.m.163.com/nc/video/home/0-10.html";

@interface VideoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSDictionary *response;

@property(strong, nonatomic) VideoNewsModel *newsModel;

@property(copy, nonatomic) NSString *videoPath;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self startRequest];
//    self.videoPath = [[NSBundle mainBundle] pathForResource:@"mobileVideo.mp4" ofType:nil];
    
    
//    NSURL *url = [NSURL URLWithString:@"/Users/ihj/Library/Developer/CoreSimulator/Devices/7213D781-7552-476E-B13E-F4DD1E9F64B2/data/Containers/Bundle/Application/6EA9EA40-D3B1-4175-9F87-30160055466E/NetEase.app/mobileVideo.mp4"];
//    
//    AVPlayer * player = [[AVPlayer alloc] initWithURL: [NSURL URLWithString:@"http://125.39.68.200/mp4files/3105000001DBE22B/61.179.107.154/flv2.bn.netease.com/videolib3/1509/05/ZxDoH1869/SD/ZxDoH1869-mobile.mp4"]];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    playerLayer.frame = self.view.bounds;
//    [self.view.layer addSublayer:playerLayer];
//    [player play];
//    self.view.backgroundColor = [UIColor whiteColor];
}


- (void) setupSubViews{
    //    init tableView
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoNewsCell" bundle:nil] forCellReuseIdentifier:kVideoNewsCell];
//
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.view addSubview:self.tableView];
}


- (void)headerRereshing{
    
}

- (void) startRequest{
    
    __weak typeof(self) weakSelf = self;
    [[AFHTTPRequestOperationManager manager] GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([weakSelf.tableView.header isRefreshing]) {
            [weakSelf.tableView.header endRefreshing];
        }
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.response = (NSDictionary *)responseObject;
            [weakSelf buildData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"fail");
        if ([weakSelf.tableView.header isRefreshing]) {
            [weakSelf.tableView.header endRefreshing];
        }
    }];
}

- (void)buildData{
    [VideoNewsModel setupObjectClassInArray:^NSDictionary *{
        return @{@"videoSidList" : @"VideoTopicModel", @"videoList" : @"VideoContentModel"};
    }];
    
    self.newsModel = [VideoNewsModel objectWithKeyValues:self.response];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.newsModel.videoList.count + self.newsModel.videoSidList.count;
    return self.newsModel.videoList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoNewsCell forIndexPath:indexPath];
    [cell buildVideoNewsCell:self.newsModel.videoList[indexPath.section]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [VideoNewsCell heightOfCell];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 3;
}


- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoNewsCell *videoCell = (VideoNewsCell *)cell;
    [videoCell stopWhenPlaying];
}
@end
