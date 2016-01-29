//
//  ZLDropDownMenuTitleButton.h
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/27.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLDropDownMenuTitleButton : UIButton

@property (nonatomic, strong) UIColor *arrowColor;
@property (nonatomic, strong) UIColor *mainTitleColor;
@property (nonatomic, strong) UIColor *subTitleColor;
@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithMainTitle:(NSString *)mainTitle
                         subTitle:(NSString *)subTitle;

- (instancetype)initWithTitle:(NSString *)title;

@end
