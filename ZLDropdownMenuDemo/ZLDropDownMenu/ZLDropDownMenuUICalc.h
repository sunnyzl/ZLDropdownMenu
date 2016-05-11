//
//  ZLDropDownMenuUICalc.h
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/28.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kRGBColorFromHex(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]

#define kDropdownMenuSeperatorColor               kRGBColorFromHex(0xF3F3F4)
#define kDropdownMenuSelectedCellColor            kRGBColorFromHex(0x05CBD8)
#define kDropdownMenuUnselectedCellTextColor      kRGBColorFromHex(0x1D1D26)
#define kDropdownMenuIndicatorColor               kRGBColorFromHex(0x02C1CD)
#define kDropdownMenuTitleColor                   kRGBColorFromHex(0x1D1D26)

#define WS(weakSelf)                              __weak __typeof(&*self) weakSelf = self
#define SS(strongSelf)                            __strong __typeof(&*weakSelf) strongSelf = weakSelf
typedef struct {
    CGFloat ANIMATION_DURATION;
}ZLDROPDOWNMENU_MENU_UI_VALUE;

typedef struct {
    CGFloat MAINTITLELABEL_FONT;
    
    CGFloat SUBTITLELABEL_FONT;
    CGFloat SUBTITLELABEL_TOPMARGIN;
    
    CGFloat ARROWVIEW_LEFTMARGIN;
    CGFloat ARROWVIEW_HEIGHT;
    CGFloat ARROWVIEW_WIDTH;
    
    CGFloat BOTTOMLINE_HEIGHT;
    CGFloat BOTTOMSEPERATOR_HEIGHT;
    CGFloat RIGHTSEPERATOR_WIDTH;
    
}ZLDROPDOWNMENU_TITLEBUTTON_UI_VALUE;

typedef struct {
    CGFloat CELL_HEIGHT;
    CGFloat CELL_WIDTH;
    CGFloat LINESPACING;
    CGFloat INTERITEMSPACING;
    UIEdgeInsets SECTIONINSETS;
    CGSize ITEMSIZE;
    CGFloat CELL_LABEL_FONT;
    CGFloat CELL_LABEL_CORNERRADIUS;
    //  有多少列cell
    NSInteger VIEW_COLUMNCOUNT;
    
    CGFloat VIEW_TOP_BOTTOM_MARGIN;
    CGFloat VIEW_LEFT_RIGHT_MARGIN;
    
}ZLDROPDOWNMENU_COLLECTIONVIEW_UI_VALUE;

ZLDROPDOWNMENU_MENU_UI_VALUE *dropDownMenuUIValue();
ZLDROPDOWNMENU_TITLEBUTTON_UI_VALUE *dropDownMenuTitleButtonUIValue();
ZLDROPDOWNMENU_COLLECTIONVIEW_UI_VALUE *dropDownMenuCollectionViewUIValue();

CGFloat deviceWidth();
CGFloat deviceHeight();