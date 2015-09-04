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

static NSString *requestUrl = @"http://c.3g.163.com/nc/article/headline/T1348647853363/0-140.html";

static NSString *dictKey = @"T1348647853363";

@interface TopicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;

@property(strong, nonatomic) NSDictionary *response;

@property(copy, nonatomic) NSArray *cellDataArray;

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self startRequest];
}

- (void) setupSubViews{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicNewsCell" bundle:nil] forCellReuseIdentifier:kTopicNewsCell];
    [self.view addSubview:self.tableView];
}


- (void) startRequest{
    
    __weak typeof(self) weakSelf = self;
    [[AFHTTPRequestOperationManager manager] GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            weakSelf.response = (NSDictionary *)responseObject;
            [weakSelf buildData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"fail");
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
    TopicNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopicNewsCell forIndexPath:indexPath];
    TopicNewsModel *model = [self.cellDataArray objectAtIndex:indexPath.row];
    [cell buildCell:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TopicNewsCell height];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDataArray.count;
}














@end
