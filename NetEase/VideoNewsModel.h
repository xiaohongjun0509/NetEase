//
//  VideoNewsModel.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoNewsModel : NSObject

//@property (copy, nonatomic) NSString *name;
@property(strong, nonatomic) NSArray *videoSidList;

@property(strong, nonatomic) NSArray *videoList;

@end
