//
//  TopicNewsCell.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "TopicNewsCell.h"
#import "Common.h"
@interface TopicNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *digest;

@end

@implementation TopicNewsCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)buildCell:(TopicNewsModel *)model{
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.title.text = model.title;
    self.digest.text = model.digest;
}

+ (CGFloat)height{
    return 68;
}

@end
