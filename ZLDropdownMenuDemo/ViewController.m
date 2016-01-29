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
#import "NSString+ZLStringSize.h"

@interface ViewController () <ZLDropDownMenuDelegate, ZLDropDownMenuDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *mainTitleArray;
@property (nonatomic, strong) NSArray *subTitleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainTitleArray = @[@"BOOKS", @"MOVIES", @"HOME", @"MUSIC"];
    _subTitleArray = @[
                       @[@"All", @"Arts", @"Photography", @"Biographies", @"Memoirs", @"Business", @"Calendars", @"Education", @"Comics", @"Computers", @"Transpotation", @"History"],
                       @[@"All", @"Animation", @"Drama", @"Comedy"],
                       @[@"All", @"Furniture", @"Bedding", @"Bath", @"Artwork"],
                       @[@"All", @"Blues", @"Christian", @"Classical", @"Country", @"Jazz", @"Pop", @"Folk", @"Gospel"]
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
