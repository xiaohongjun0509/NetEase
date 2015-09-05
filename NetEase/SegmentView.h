//
//  SegmentView.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentView;
@protocol SegmentViewDelegate <NSObject>

- (void)segmentView:(SegmentView *) view didClickAtIndex:(NSInteger)index;

@end

@interface SegmentView : UIView

@property (assign, nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) id<SegmentViewDelegate> delegate;

@end
