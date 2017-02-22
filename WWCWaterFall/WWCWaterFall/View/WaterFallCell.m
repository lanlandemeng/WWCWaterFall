//
//  WaterFallCell.m
//  WWCWaterFall
//
//  Created by WeiChaoW on 2017/2/22.
//  Copyright © 2017年 WeiChaoW. All rights reserved.
//

#import "WaterFallCell.h"
#import "Model.h"
#import "UIImageView+WebCache.h"

@interface WaterFallCell ()

@property (nonatomic, weak) UIImageView *imageView;//图片视图

@end

@implementation WaterFallCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}
- (void)setModel:(Model *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:model.imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
