//
//  TopicNewsModel.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSString, CellSkipType) {
//    CellSkipTypePhotoSet = @"photoset",
//};


@interface TopicNewsModel : NSObject
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *digest;
@property (copy, nonatomic) NSString *imgsrc;
@property (assign, nonatomic) NSInteger replyCount;
//专题标志
@property (copy, nonatomic) NSString *skipType;

@property (copy, nonatomic) NSArray *imgextra;
@end
