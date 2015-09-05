//
//  MediaNewsModel.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaNewsModel : NSObject
@property (copy, nonatomic) NSString *cname;
@property (copy, nonatomic) NSArray *tList;
@property (copy, nonatomic) NSString *cid;

//@property(strong, nonatomic) NSMutableArray *modelList;
@end
