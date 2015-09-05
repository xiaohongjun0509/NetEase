//
//  MediaNewsCell.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MediaNewsModel.h"

static NSString * const kMediaNewsCell = @"MediaNewsCell";

@interface MediaNewsCell : UITableViewCell

- (void)buildMediaCell:(MediaNewsModel *)model;


+(CGFloat) heightOfMediaNewsCell;
@end
