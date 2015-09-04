//
//  TopicNewsCell.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicNewsModel.h"

static NSString * const kTopicNewsCell = @"TopicNewsCell";


@interface TopicNewsCell : UITableViewCell

- (void)buildCell:(TopicNewsModel *)model;

+ (CGFloat) height;

@end
