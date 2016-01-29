//
//  NSString+ZLStringSize.h
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/27.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (ZLStringSize)

- (CGSize)zl_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
- (CGSize)zl_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)zl_stringSizeWithFont:(UIFont *)font;

@end
