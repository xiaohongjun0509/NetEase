//
//  AudioViewController.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "AudioViewController.h"
#import "MediaNewsCell.h"
#import "Common.h"
#import "MediaModel.h"
#import "MediaRadioModel.h"

static NSString *const requestUrl = @"http://c.m.163.com/nc/topicset/ios/radio/index.html";

static NSString *const rootKey = @"cList";

@interface AudioViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSDictionary *response;

@property(strong, nonatomic) NSMutableArray *dataArray;

@property(strong, nonatomic) NSMutableArray *modelArray;

@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self startRequest];
}


- (void) setupSubViews{
    //    init tableView
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MediaNewsCell" bundle:nil] forCellReuseIdentifier:kMediaNewsCell];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.view addSubview:self.tableView];
}


- (void)headerRereshing{
    [self startRequest];
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

- (void) buildData{
    self.modelArray = [NSMutableArray array];
    self.dataArray = self.response[rootKey];
   //这个解析要特别注意,告诉数组里面存放的是什么。
    [MediaNewsModel setupObjectClassInArray:^NSDictionary *{
        return @{@"tList" : @"MediaModel"};
    }];
    [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
           MediaNewsModel * mediaNewsModel = [MediaNewsModel objectWithKeyValues:dic];
            [self.modelArray addObject:mediaNewsModel];
        }
    }];
  
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MediaNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kMediaNewsCell forIndexPath:indexPath];
    [cell buildMediaCell:self.modelArray[indexPath.section]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MediaNewsCell heightOfMediaNewsCell];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 3;
}

@end
