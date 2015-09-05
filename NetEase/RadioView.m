//
//  RadioView.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "RadioView.h"
#import "Common.h"

@interface RadioView ()
@property (weak, nonatomic) IBOutlet UIImageView *ablumImageView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *countBUtton;

@end



@implementation RadioView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.playButton.center = self.ablumImageView.center;
    self.ablumImageView.layer.cornerRadius = self.ablumImageView.frame.size.width / 2;
    self.ablumImageView.layer.masksToBounds = YES;
    
}


- (void)buildRadioView:(MediaModel *)model{
    [self.ablumImageView sd_setImageWithURL:[NSURL URLWithString:model.radio.imgsrc]];
    self.titleLabel.text = model.tname;
    self.subTitleLabel.text = model.radio.title;
    [self.countBUtton setTitle:[NSString stringWithFormat:@"%d",(int)model.playCount ] forState:UIControlStateNormal];
}

+ (CGFloat)heightOfView{
    return 180;
}

@end
