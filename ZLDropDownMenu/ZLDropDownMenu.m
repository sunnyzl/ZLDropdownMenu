//
//  ZLDropDownMenu.m
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/27.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "ZLDropDownMenu.h"
#import "Masonry.h"
#import "ZLDropDownMenuTitleButton.h"
#import "ZLDropDownMenuUICalc.h"
#import "ZLDropDownMenuCollectionViewCell.h"

typedef void(^ZLDropDownMenuAnimateCompleteHandler)(void);

@implementation ZLIndexPath
- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _row = row;
    }
    return self;
}

+ (instancetype)indexPathWithColumn:(NSInteger)col row:(NSInteger)row {
    ZLIndexPath *indexPath = [[self alloc] initWithColumn:col row:row];
    return indexPath;
}
@end

@interface ZLDropDownMenu () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, assign) NSInteger currentSelectedMenuIndex;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, strong) UICollectionView *collectionView;

//  dataSource
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, weak) ZLDropDownMenuTitleButton *selectedButton;
@property (nonatomic, weak) ZLDropDownMenuCollectionViewCell *defaultSelectedCell;

@end

static NSString * const collectionCellID = @"ZLDropDownMenuCollectionViewCell";
@implementation ZLDropDownMenu
#pragma mark - initialize
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _currentSelectedMenuIndex = -1;
        _show = NO;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = dropDownMenuCollectionViewUIValue()->SECTIONINSETS;
        flowLayout.itemSize = dropDownMenuCollectionViewUIValue()->ITEMSIZE;
        flowLayout.minimumLineSpacing = dropDownMenuCollectionViewUIValue()->LINESPACING;
        flowLayout.minimumInteritemSpacing = dropDownMenuCollectionViewUIValue()->INTERITEMSPACING;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.collectionViewLayout = flowLayout;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZLDropDownMenuCollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizesSubviews = NO;
        self.autoresizesSubviews = NO;
        
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.f];
        _backgroundView.opaque = NO;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTap:)];
        [_backgroundView addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - setter
- (void)setFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, deviceWidth(), frame.size.height);
    [super setFrame:frame];
}

- (void)setDataSource:(id<ZLDropDownMenuDataSource>)dataSource
{
    _dataSource = dataSource;
    NSAssert([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)], @"does not respond 'numberOfColumnsInMenu:' method");
    _numOfMenu = [_dataSource numberOfColumnsInMenu:self];
    
    __weak typeof(self) weakSelf = self;
    CGFloat width = deviceWidth() / _numOfMenu;
    _titleButtons = [NSMutableArray arrayWithCapacity:_numOfMenu];
    ZLDropDownMenuTitleButton *lastTitleButton = nil;
    for (NSInteger index = 0; index < _numOfMenu; index++) {
        
        NSString *titleString = [_dataSource menu:self titleForRowAtIndexPath:[ZLIndexPath indexPathWithColumn:index row:0]];
        ZLDropDownMenuTitleButton *titleButton = [[ZLDropDownMenuTitleButton alloc] initWithMainTitle:[_dataSource menu:self titleForColumn:index] subTitle:titleString];
        [self addSubview:titleButton];
        [_titleButtons addObject:titleButton];
        [titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            make.width.mas_equalTo(width);
            make.left.equalTo(lastTitleButton ? lastTitleButton.mas_right : weakSelf);
        }];
        

        lastTitleButton = titleButton;
        if (index != _numOfMenu - 1) {
            UIView *rightSeperator = [[UIView alloc] init];
            rightSeperator.backgroundColor = kDropdownMenuSeperatorColor;
            [titleButton addSubview:rightSeperator];
            [rightSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.equalTo(titleButton);
                make.width.mas_equalTo(dropDownMenuTitleButtonUIValue()->RIGHTSEPERATOR_WIDTH);
            }];
        }
        titleButton.index = index;
        [titleButton addTarget:self action:@selector(titleButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - animation method
- (void)animationWithTitleButton:(ZLDropDownMenuTitleButton *)button BackgroundView:(UIView *)backgroundView
                     collectionView:(UICollectionView *)collectionView
                               show:(BOOL)isShow
                           complete:(ZLDropDownMenuAnimateCompleteHandler)complete
{
    if (self.selectedButton == button) {
        button.selected = isShow;
    } else {
        button.selected = YES;
        self.selectedButton.selected = NO;
        self.selectedButton = button;
    }
    [self animationWithBackgroundView:backgroundView show:isShow complete:^{
        [self animationWithCollectionView:collectionView show:isShow complete:nil];
    }];
    if (complete) {
        complete();
    }
}


- (void)animationWithBackgroundView:(UIView *)backgroundView
                     collectionView:(UICollectionView *)collectionView
                            show:(BOOL)isShow
                           complete:(ZLDropDownMenuAnimateCompleteHandler)complete
{
    [self animationWithBackgroundView:backgroundView show:isShow complete:^{
        [self animationWithCollectionView:collectionView show:isShow complete:nil];
    }];
    if (complete) {
        complete();
    }
}

- (void)animationWithBackgroundView:(UIView *)backgroundView
                               show:(BOOL)isShow
                           complete:(ZLDropDownMenuAnimateCompleteHandler)complete
{
    __weak typeof(self) weakSelf = self;
    if (isShow) {
        if (1 == clickCount) {
            [self.superview addSubview:backgroundView];
            [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.mas_bottom);
                make.left.right.bottom.equalTo(weakSelf.superview);
            }];
            [backgroundView layoutIfNeeded];
        }
        [UIView animateWithDuration:dropDownMenuUIValue()->ANIMATION_DURATION animations:^{
            backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:dropDownMenuUIValue()->ANIMATION_DURATION animations:^{
            backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            clickCount = 0;
        }];
    }
    if (complete) {
        complete();
    }
}

- (void)animationWithCollectionView:(UICollectionView *)collectionView
                               show:(BOOL)isShow
                           complete:(ZLDropDownMenuAnimateCompleteHandler)complete
{
    __weak typeof(self) weakSelf = self;
    if (isShow) {
        CGFloat collectionViewHeight = 0.f;
        if (collectionView) {
            CGFloat height = 0.f;
            NSInteger rowCount = (NSInteger)ceilf((CGFloat)[collectionView numberOfItemsInSection:0] / dropDownMenuCollectionViewUIValue()->VIEW_COLUMNCOUNT);
            collectionViewHeight = dropDownMenuCollectionViewUIValue()->VIEW_TOP_BOTTOM_MARGIN * 2 + dropDownMenuCollectionViewUIValue()->CELL_HEIGHT * rowCount + dropDownMenuCollectionViewUIValue()->LINESPACING * (rowCount - 1);
            CGFloat maxHeight = deviceHeight() - CGRectGetMaxY(self.frame);
            collectionViewHeight = collectionViewHeight > maxHeight ? maxHeight : collectionViewHeight;
            
            if (1 == clickCount) {
                [self.superview addSubview:collectionView];
                [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf.mas_bottom);
                    make.left.right.equalTo(weakSelf.superview);
                    make.height.mas_equalTo(height);
                }];
                
                [self.collectionView layoutIfNeeded];
                [UIView animateWithDuration:dropDownMenuUIValue()->ANIMATION_DURATION animations:^{
                    [collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(collectionViewHeight);
                    }];
                    [collectionView.superview layoutIfNeeded];
                }];
            } else {[UIView animateWithDuration:dropDownMenuUIValue()->ANIMATION_DURATION animations:^{
                [collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(collectionViewHeight);
                }];
                [collectionView.superview layoutIfNeeded];
            }];
        
            }
        }
        
        
    } else {
        if (collectionView) {
            
            [UIView animateWithDuration:dropDownMenuUIValue()->ANIMATION_DURATION animations:^{
                [collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                }];
                [collectionView.superview layoutIfNeeded];
            } completion:^(BOOL finished) {
                [collectionView removeFromSuperview];
            
                clickCount = 0;
            }];
        }
    }
    if (complete) {
        complete();
    }
}



#pragma mark - action method
static NSInteger clickCount;
- (void)titleButtonDidClick:(ZLDropDownMenuTitleButton *)titleButton
{
    clickCount++;
    if (titleButton.index == self.currentSelectedMenuIndex && self.isShow) {
        [self animationWithTitleButton:titleButton BackgroundView:self.backgroundView collectionView:self.collectionView show:NO complete:^{
            self.currentSelectedMenuIndex = titleButton.index;
            self.show = NO;
        }];
    } else {
        self.currentSelectedMenuIndex = titleButton.index;
        [self.collectionView reloadData];
        [self animationWithTitleButton:titleButton BackgroundView:self.backgroundView collectionView:self.collectionView show:YES complete:^{
            self.show = YES;
        }];
    }
}

- (void)backgroundViewDidTap:(UITapGestureRecognizer *)tapGesture
{
    ZLDropDownMenuTitleButton *titleButton = self.titleButtons[self.currentSelectedMenuIndex];
    [self animationWithTitleButton:titleButton BackgroundView:self.backgroundView collectionView:self.collectionView show:NO complete:^{
        self.show = NO;
    }];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSAssert([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumns:)], @"does not respond the 'menu:numberOfRowsInColumns:' method");
    return [self.dataSource menu:self numberOfRowsInColumns:self.currentSelectedMenuIndex];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLDropDownMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    NSAssert([self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)], @"does not respond the 'menu:titleForRowAtIndexPath:' method");
    cell.contentString = [self.dataSource menu:self titleForRowAtIndexPath:[ZLIndexPath indexPathWithColumn:self.currentSelectedMenuIndex row:indexPath.row]];
    if ([cell.contentString isEqualToString:[self.titleButtons[self.currentSelectedMenuIndex] subTitle]]) {
        cell.selected = YES;
        self.defaultSelectedCell = cell;
    }
    return cell;
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(self.delegate && [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)], @"does not set delegate or respond the 'menu:titleForRowAtIndexPath:' method");
    [self.delegate menu:self didSelectRowAtIndexPath:[ZLIndexPath indexPathWithColumn:self.currentSelectedMenuIndex row:indexPath.row]];
    [self configMenuSubTitleWithSelectRow:indexPath.row];
}

- (void)configMenuSubTitleWithSelectRow:(NSInteger)row
{
    ZLDropDownMenuTitleButton *button = _titleButtons[self.currentSelectedMenuIndex];
    NSString *currentSelectedTitle = [self.dataSource menu:self titleForRowAtIndexPath:[ZLIndexPath indexPathWithColumn:self.currentSelectedMenuIndex row:row]];
    button.subTitle = currentSelectedTitle;
    if (![self.defaultSelectedCell.contentString isEqualToString:currentSelectedTitle]) {
        self.defaultSelectedCell.selected = NO;
    }
    [self animationWithTitleButton:button BackgroundView:self.backgroundView collectionView:self.collectionView show:NO complete:^{
        self.show = NO;
    }];
}

@end
