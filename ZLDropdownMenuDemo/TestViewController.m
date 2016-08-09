//
//  TestViewController.m
//  ZLDropdownMenuDemo
//
//  Created by zhaoliang on 16/8/8.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "TestViewController.h"
#import "ZLDropDownMenu.h"
#import "Masonry.h"
#import "ZLDropDownMenuUICalc.h"

@interface TestViewController () <ZLDropDownMenuDelegate, ZLDropDownMenuDataSource>


@property (nonatomic, strong) NSArray *mainTitleArray;
@property (nonatomic, strong) NSArray *subTitleArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZLDropDownMenu *menu = [[ZLDropDownMenu alloc] init];
    UIView *testView = [[UIView alloc] init];
    [self.view addSubview:testView];
    testView.backgroundColor = [UIColor redColor];
    
    [testView addSubview:menu];
    WS(weakSelf);
    _mainTitleArray = @[@"BOOKS", @"MOVIES", @"HOME", @"MUSIC"];
    _subTitleArray = @[
                       @[@"All", @"Arts", @"Photography", @"Biographies", @"Memoirs", @"Business", @"Calendars", @"Education", @"Comics", @"Computers", @"Transpotation", @"History"],
                       @[@"All", @"Animation", @"Drama", @"Comedy"],
                       @[@"All", @"Furniture", @"Bedding", @"Bath", @"Artwork"],
                       @[@"All", @"Blues", @"Christian", @"Classical", @"Country", @"Jazz", @"Pop", @"Folk", @"Gospel"]
                       ];
    
//    menu.bounds = CGRectMake(0, 0, deviceWidth(), 50.f);
    
    menu.delegate = self;
    menu.dataSource = self;
    
    UIView *one = [[UIView alloc] init];
    one.backgroundColor = [UIColor blueColor];
    [self.view addSubview:one];
    
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(100.f);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(200.f);
    }];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(testView);
        make.top.mas_equalTo(100.f);
        make.height.mas_equalTo(50.f);
    }];
    [one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(300);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(100);
    }];
}


#pragma mark - ZLDropDownMenuDataSource

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
#pragma mark - ZLDropDownMenuDelegate
- (void)menu:(ZLDropDownMenu *)menu didSelectRowAtIndexPath:(ZLIndexPath *)indexPath
{
    NSArray *array = self.subTitleArray[indexPath.column];
    NSLog(@"%@", array[indexPath.row]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
