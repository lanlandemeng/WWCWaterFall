//
//  WWCWaterFallLayout.h
//  WWCWaterFall
//
//  Created by WeiChaoW on 2017/2/22.
//  Copyright © 2017年 WeiChaoW. All rights reserved.
//  自定义Layout

#import <UIKit/UIKit.h>
@class WWCWaterFallLayout;

@protocol WWCWaterFallLayoutDelegate <NSObject>
@required

/*
 计算item的高度
 @pram waterFallLayout: WWCWaterFallLayout
 @pram itemWidth: item的宽度
 @pram indexPath: item的所在位置的indexPath
 */
- (CGFloat)waterFallLayout:(WWCWaterFallLayout *)waterFallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;

@end

@interface WWCWaterFallLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger columnCount;//总共多少列
@property (nonatomic, assign) CGFloat rowSpace;//行间距
@property (nonatomic, assign) CGFloat columnSpace;//列间距
@property (nonatomic, assign) UIEdgeInsets sectionInset;//section与collectionView的间距

@property (nonatomic, weak) id<WWCWaterFallLayoutDelegate>delegate;//代理

//初始化
+ (instancetype)initWaterFallLayoutWithColumnCount:(NSInteger)columnCount;
- (instancetype)initWithColumnCount:(NSInteger)columnCount;


@end
