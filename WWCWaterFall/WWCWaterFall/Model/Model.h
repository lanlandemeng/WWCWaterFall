//
//  Model.h
//  WWCWaterFall
//
//  Created by WeiChaoW on 2017/2/22.
//  Copyright © 2017年 WeiChaoW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Model : NSObject
@property (nonatomic, copy) NSURL *imageURL;//图片链接
@property (nonatomic, assign) CGFloat imageW;//宽
@property (nonatomic, assign) CGFloat imageH;//高

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
