//
//  VideoNewsCell.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoContentModel.h"
static NSString *const kVideoNewsCell = @"VideoNewsCell";

@interface VideoNewsCell : UITableViewCell

+(CGFloat) heightOfCell;

-(void)buildVideoNewsCell:(VideoContentModel *)model;

- (void)stopWhenPlaying;
@end
