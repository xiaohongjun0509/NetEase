//
//  MediaModel.h
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MediaRadioModel.h"

@interface MediaModel : NSObject

@property (copy, nonatomic) NSString *tname;

@property (assign, nonatomic) NSInteger playCount;


//@property(strong, nonatomic) NSDictionary *radio;
@property(strong, nonatomic) MediaRadioModel *radio;


@end
