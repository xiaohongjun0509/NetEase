//
//  TopicNewsMultiImageCell.m
//  NetEase
//
//  Created by ihj on 15/9/5.
//  Copyright (c) 2015年 ihj. All rights reserved.
//

#import "TopicNewsMultiImageCell.h"
#import "Common.h"

@interface TopicNewsMultiImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ivCollection;



@end

@implementation TopicNewsMultiImageCell

- (void)awakeFromNib {
    
}

- (void)buildCell:(TopicNewsModel *)model{
    [self.ivCollection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            [(UIImageView *)obj sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        }else{
            NSString *urlString = [((NSDictionary *)(model.imgextra[idx - 1])) valueForKey:@"imgsrc"];
            [(UIImageView *)obj sd_setImageWithURL:[NSURL URLWithString:urlString]];
        }
    }];
    self.titleLabel.text = model.title;
}

+ (CGFloat)height{
    return 100;
}

@end
