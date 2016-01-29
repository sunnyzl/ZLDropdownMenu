//
//  ViewController.m
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/27.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ZLDropDownMenuUICalc.h"
#import "ZLDropDownMenuCollectionViewCell.h"
#import "ZLDropDownMenu.h"

@interface ViewController () <ZLDropDownMenuDelegate, ZLDropDownMenuDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *mainTitleArray;
@property (nonatomic, strong) NSArray *subTitleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainTitleArray = @[@"主题市场", @"特色购物", @"优惠促销", @"潮流女装"];
    _subTitleArray = @[
                       @[@"全部", @"汽车", @"数码", @"家电", @"游戏", @"生活", @"学习", @"房产", @"户外", @"运动", @"娱乐", @"美妆"],
                       @[@"全部", @"青年", @"中老年", @"批发量贩"],
                       @[@"全部", @"天天特价", @"试用", @"抢新", @"清仓"],
                       @[@"全部", @"韩版", @"连衣裙", @"棉衣", @"套装", @"冬季新品", @"毛衣", @"半裙", @"品牌特卖"]
                       ];
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(100.f);
    }];
    ZLDropDownMenu *menu = [[ZLDropDownMenu alloc] init];
    [self.view addSubview:menu];
    menu.delegate = self;
    menu.dataSource = self;
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (NSInteger)numberOfColumnsInMenu:(ZLDropDownMenu *)menu
{
    return self.mainTitleArray.count;
}

- (NSInteger)menu:(ZLDropDownMenu *)menu numberOfRowsInColumns:(NSInteger)column
{
    return [self.subTitleArray[column] count];
}

- (NSString *)menu:(ZLDropDownMenu *)menu titleForColumn:(NSInteger)column
{
    return self.mainTitleArray[column];
}

- (NSString *)menu:(ZLDropDownMenu *)menu titleForRowAtIndexPath:(ZLIndexPath *)indexPath
{
    NSArray *array = self.subTitleArray[indexPath.column];
    return array[indexPath.row];
}

- (void)menu:(ZLDropDownMenu *)menu didSelectRowAtIndexPath:(ZLIndexPath *)indexPath
{
    NSArray *array = self.subTitleArray[indexPath.column];
    NSLog(@"%@", array[indexPath.row]);
}
@end
