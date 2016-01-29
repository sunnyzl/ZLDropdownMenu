//
//  ZLDropDownMenu.h
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/27.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLIndexPath : NSObject

@property (nonatomic, assign) NSInteger column;
@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithColumn:(NSInteger)col row:(NSInteger)row;

@end

@class ZLDropDownMenu;

@protocol ZLDropDownMenuDataSource <NSObject>
@required
- (NSInteger)numberOfColumnsInMenu:(ZLDropDownMenu *)menu;
- (NSInteger)menu:(ZLDropDownMenu *)menu numberOfRowsInColumns:(NSInteger)column;
- (NSString *)menu:(ZLDropDownMenu *)menu titleForColumn:(NSInteger)column;
@optional
- (NSString *)menu:(ZLDropDownMenu *)menu titleForRowAtIndexPath:(ZLIndexPath *)indexPath;
@end

@protocol ZLDropDownMenuDelegate <NSObject>

@optional
- (void)menu:(ZLDropDownMenu *)menu didSelectRowAtIndexPath:(ZLIndexPath *)indexPath;
@end

@interface ZLDropDownMenu : UIView

@property (nonatomic, weak) id <ZLDropDownMenuDataSource>dataSource;
@property (nonatomic, weak) id <ZLDropDownMenuDelegate>delegate;

@end
