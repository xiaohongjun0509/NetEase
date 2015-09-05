//
//  TopicViewController.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "TopicViewController.h"

#import "Common.h"

#import "TopicNewsCell.h"

#import "TopicNewsModel.h"

#import "TopicNewsMultiImageCell.h"

#import "MJRefresh.h"

static NSString *requestUrl = @"http://c.3g.163.com/nc/article/headline/T1348647853363/0-140.html";

static NSString *dictKey = @"T1348647853363";

static NSString * const photoset = @"photoset";

@interface TopicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSDictionary *response;

@property(copy, nonatomic) NSArray *cellDataArray;

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupNavigationBar];
    [self startRequest];
}


- (void)setupNavigationBar{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_header_logo"]];
    
    
}
- (void) setupSubViews{
//    init tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicNewsCell" bundle:nil] forCellReuseIdentifier:kTopicNewsCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicNewsMultiImageCell" bundle:nil ] forCellReuseIdentifier:kTopicNewsMultiImageCell];
    
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
    NSArray *resArray = [self.response valueForKey:dictKey];
    NSMutableArray *tmpResArray = [NSMutableArray arrayWithArray:resArray];
    [tmpResArray removeObjectAtIndex:0];
    
    self.cellDataArray = [TopicNewsModel objectArrayWithKeyValuesArray:tmpResArray];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TopicNewsModel *model = [self.cellDataArray objectAtIndex:indexPath.row];
    
    if (!model.skipType || model.skipType.length == 0) {
        TopicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopicNewsCell forIndexPath:indexPath];
        
        [cell buildCell:model];
        return cell;

    }else if( [photoset isEqualToString:model.skipType]){
        TopicNewsMultiImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopicNewsMultiImageCell forIndexPath:indexPath];
        [cell buildCell:model];
        return cell;
    }
    return [UITableViewCell new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicNewsModel *model = [self.cellDataArray objectAtIndex:indexPath.row];
    if (!model.skipType || model.skipType.length == 0) {
        return [TopicNewsCell height];
        
    }else if( [photoset isEqualToString:model.skipType]){
        return [TopicNewsMultiImageCell height];
    }
//    return [TopicNewsCell height];
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDataArray.count;
}










@end
