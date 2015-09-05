//
//  SegmentView.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "SegmentView.h"
#define  TAGOFFSET 1001

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.height / 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        [self setupButtons];
    }
    return self;
}

- (void)setupButtons{
    UIButton *button1 = [[UIButton alloc] init];
    button1.tag = 1001;
    button1.frame = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height);
    button1.layer.cornerRadius = self.frame.size.height / 2;
    [button1 setTitle:@"视频" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"ceremony_article_vote_normal"] forState:UIControlStateNormal];
//    [button1 setBackgroundImage:[UIImage imageNamed:@"bobo_logo"] forState:UIControlStateSelected];
    [button1 setBackgroundColor:[UIColor grayColor]];
    [button1 setSelected:YES];
    [button1 addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.tag = 1002;
    button2.frame = CGRectMake(self.frame.size.width / 2, 0, self.frame.size.width / 2, self.frame.size.height);
    button2.layer.cornerRadius = self.frame.size.height / 2;
    [button2 setTitle:@"电台" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button2 setBackgroundImage:[UIImage imageNamed:@"ceremony_article_vote_normal"] forState:UIControlStateNormal];
//    [button2 setBackgroundImage:[UIImage imageNamed:@"bobo_logo"] forState:UIControlStateSelected];
    [button2 setBackgroundColor:[UIColor grayColor]];
    [button2 addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];

}

-(void)clicked:(UIButton *)sender{
    NSInteger selectedIndex = sender.tag - 1001;
    if (self.selectedIndex == selectedIndex) {
        return;
    }
    self.selectedIndex = selectedIndex;
    if (selectedIndex == 0) {
        UIButton *button = (UIButton *)[self viewWithTag:selectedIndex + TAGOFFSET];
        [button setSelected:YES];
        button = (UIButton *)[self viewWithTag:1002];
        [button setSelected:NO];
    }else{
        UIButton *button = (UIButton *)[self viewWithTag:selectedIndex + TAGOFFSET];
        [button setSelected:YES];
        button = (UIButton *)[self viewWithTag:1001];
        [button setSelected:NO];
    }
    if (self.delegate) {
        [self.delegate segmentView:self didClickAtIndex:self.selectedIndex];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
