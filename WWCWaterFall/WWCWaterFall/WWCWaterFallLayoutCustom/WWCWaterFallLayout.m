//
//  WWCWaterFallLayout.m
//  WWCWaterFall
//
//  Created by WeiChaoW on 2017/2/22.
//  Copyright © 2017年 WeiChaoW. All rights reserved.
//

#import "WWCWaterFallLayout.h"
@interface WWCWaterFallLayout()

@property (nonatomic, strong) NSMutableArray *attributesArray;//存储每一个item的attributes
@property (nonatomic, strong) NSMutableDictionary *maxYDictionary;//存储每一个item的最大的y值


@end

@implementation WWCWaterFallLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.columnCount = 3;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount{
    self = [super init];
    if (self) {
        self.columnCount = columnCount;
    }
    return self;
}

+ (instancetype)initWaterFallLayoutWithColumnCount:(NSInteger)columnCount{
    return [[self alloc] initWithColumnCount:columnCount];
}

- (void)prepareLayout{
    [super prepareLayout];
    //每一个item的最大y值初始化为上边距
    for (NSInteger i=0; i<self.columnCount; i++) {
        [self.maxYDictionary setObject:@(self.sectionInset.top) forKey:@(i)];
    }
    //获取collectionView上item的总数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //存储每一个item的attributes
    [self.attributesArray removeAllObjects];
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attributes];
    }
}

//计算collectionView的contentSize
- (CGSize)collectionViewContentSize{
    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列是第几个
    [self.maxYDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDictionary[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    CGFloat height = [self.maxYDictionary[maxIndex] floatValue] + self.sectionInset.bottom;
    return CGSizeMake(0, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    //计算item的宽度
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpace)/self.columnCount;
    //获取item高度
    CGFloat itemHeight = 0;
    if ([self.delegate respondsToSelector:@selector(waterFallLayout:itemHeightForWidth:atIndexPath:)]) {
        itemHeight = [self.delegate waterFallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
    }
    //找出最短的那一列的item
    __block NSNumber *minIndex = @0;
    [self.maxYDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDictionary[minIndex] floatValue] > [obj floatValue]) {
            minIndex = key;
        }
    }];
    
    //计算item的x值
    CGFloat itemMinX = self.sectionInset.left + (self.columnSpace +itemWidth) *minIndex.integerValue;
    CGFloat itemMinY = [self.maxYDictionary[minIndex] floatValue] + self.rowSpace;
    attributes.frame = CGRectMake(itemMinX, itemMinY, itemWidth, itemHeight);
    //重新设置字典中的最大值
    self.maxYDictionary[minIndex] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

//返回item的attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

#pragma mark - 懒加载
- (NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (NSMutableDictionary *)maxYDictionary{
    if (_maxYDictionary == nil) {
        _maxYDictionary = [NSMutableDictionary dictionary];
    }
    return _maxYDictionary;
}

@end
