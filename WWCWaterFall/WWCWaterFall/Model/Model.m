//
//  Model.m
//  WWCWaterFall
//
//  Created by WeiChaoW on 2017/2/22.
//  Copyright © 2017年 WeiChaoW. All rights reserved.
//

#import "Model.h"

@implementation Model
+ (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    Model *model = [[Model alloc] init];
    model.imageURL = [NSURL URLWithString:dictionary[@"img"]];
    model.imageW = [dictionary[@"w"] floatValue];
    model.imageH = [dictionary[@"h"] floatValue];
    return model;
}

@end
