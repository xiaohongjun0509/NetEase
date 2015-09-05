//
//  VideoContentModel.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoContentModel : NSObject


@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *mp4_url;

//@property (copy, nonatomic) NSString *description;

@property (copy, nonatomic) NSString *cover;

@property (copy, nonatomic) NSString *length;

@property (copy, nonatomic) NSString *playCount;

@end
