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
    [self.countBUtton setTitle:[self countFormet:model.playCount ] forState:UIControlStateNormal];
}

- (NSString *)countFormet:(NSInteger)count{
    if (count > 10000) {
        count = count * 10 / 10000;
        return [NSString stringWithFormat:@"%.1f万",(CGFloat)count / 10];
    }else{
        return [NSString stringWithFormat:@"%d",(int)count];
    }
}

+ (CGFloat)heightOfView{
    return 185;
}

@end
