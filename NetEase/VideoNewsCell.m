//
//  VideoNewsCell.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "VideoNewsCell.h"
#import <AVFoundation/AVFoundation.h>
#import "Common.h"

@interface VideoNewsCell ()
@property(strong, nonatomic) VideoContentModel * model;

@property (assign, nonatomic) BOOL isPlaying;

@property (weak, nonatomic) IBOutlet UIView *playerView;

@property (strong, nonatomic) AVPlayer *player;

@property(strong, nonatomic) AVPlayerLayer *playerLayer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)play:(id)sender;

@end

@implementation VideoNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    NSURL *url = [NSURL URLWithString:@"/Users/ihj/Library/Developer/CoreSimulator/Devices/7213D781-7552-476E-B13E-F4DD1E9F64B2/data/Containers/Bundle/Application/6EA9EA40-D3B1-4175-9F87-30160055466E/NetEase.app/mobileVideo.mp4"];
//
//    self.player = [[AVPlayer alloc] initWithURL: url];
//    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playerLayer.frame = self.playerView.bounds;
//    [self.playerView.layer addSublayer:self.playerLayer];
}

- (void)buildVideoNewsCell:(VideoContentModel *)model{
    self.model = model;
    self.titleLabel.text = model.title;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
}


+ (CGFloat)heightOfCell{
    return 323;
}


- (IBAction)play:(id)sender {
    self.player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.model.mp4_url]];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.playerView.bounds;
    [self.playerView.layer addSublayer:self.playerLayer];
    [self.player play];
    self.isPlaying = YES;
    self.coverImageView.hidden = YES;
}

- (void)stopWhenPlaying{
    if (self.isPlaying) {
        [self.player pause];
        self.isPlaying = NO;
        self.player = nil;
        self.coverImageView.hidden = NO;
        if (self.playerLayer.superlayer) {
            [self.playerLayer removeFromSuperlayer];
        }
    }
    
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    [super hitTest:point withEvent:event];
//    
//    CALayer *hitLayer = [self.layer hitTest:point];
//    if (hitLayer == self.playerLayer) {
//        NSLog(@"hit");
//        return self.playerView;
//    }
//    return [super hitTest:point withEvent:event];
//}
@end
