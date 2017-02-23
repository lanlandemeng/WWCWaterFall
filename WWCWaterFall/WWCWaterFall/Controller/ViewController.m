//
//  ViewController.m
//  WWCWaterFall
//
//  Created by WeiChaoW on 2017/2/22.
//  Copyright © 2017年 WeiChaoW. All rights reserved.
//

#import "ViewController.h"
#import "WWCWaterFallLayout.h"
#import "WaterFallCell.h"
#import "Model.h"

@interface ViewController ()<UICollectionViewDataSource,WWCWaterFallLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_collectionView reloadData];
}

#pragma mark - WWCWaterFallLayout的代理
- (CGFloat)waterFallLayout:(WWCWaterFallLayout *)waterFallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath{
    Model *model = self.dataArray[indexPath.item];
    return model.imageH / model.imageW * itemWidth;
}
#pragma mark - 添加collectionView
- (void)createCollectionView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    WWCWaterFallLayout *waterFall = [WWCWaterFallLayout initWaterFallLayoutWithColumnCount:3];
    waterFall.rowSpace = 10;
    waterFall.columnSpace = 10;
    waterFall.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    waterFall.delegate = self;
    _collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20) collectionViewLayout:waterFall];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[WaterFallCell class] forCellWithReuseIdentifier:@"waterFallCell"];
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}
#pragma mark - UICollectionView的代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterFallCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}
#pragma amrk - 懒加载
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"waterFall.plist" ofType:nil];
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *imageDic in imageDics) {
            Model *model = [Model initWithDictionary:imageDic];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
