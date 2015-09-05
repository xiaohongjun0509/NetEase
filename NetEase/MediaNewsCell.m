//
//  MediaNewsCell.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "MediaNewsCell.h"

#import "RadioView.h"

#import "Common.h"

CGFloat const padding = 5;

@interface MediaNewsCell ()

@property(strong, nonatomic) NSMutableArray *ablumArray;
@property (weak, nonatomic) IBOutlet UIImageView *ablimHeadIV;
@property (weak, nonatomic) IBOutlet UILabel *cNameLabel;

@end

@implementation MediaNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.ablumArray = [NSMutableArray arrayWithCapacity:3];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = (screenWidth - 4 * padding) / 3;
    for (int i = 0; i < 3; i++) {
        UIView *ablumView =[[[NSBundle mainBundle] loadNibNamed:@"RadioView" owner:self options:nil] firstObject];
        ablumView.frame = CGRectMake(padding * (i + 1) + i * width , 40, width, [RadioView heightOfView]);
        [self addSubview:ablumView];
        [self.ablumArray addObject:ablumView];
    }
}

- (void)buildMediaCell:(MediaNewsModel *)model{
//    self.ablimHeadIV sd_setImageWithURL:[NSURL URLWithString:model.]
    self.cNameLabel.text = model.cname;
    [self.ablumArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RadioView *radioView = (RadioView *)obj;
        [radioView buildRadioView:model.tList[idx]];
    }];
}


+ (CGFloat)heightOfMediaNewsCell{
    return [RadioView heightOfView] + 40;
}


@end
