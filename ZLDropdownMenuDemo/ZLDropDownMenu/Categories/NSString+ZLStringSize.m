//
//  NSString+ZLStringSize.m
//  ZLDropDownMenuDemo
//
//  Created by zhaoliang on 16/1/27.
//  Copyright © 2016年 zhao. All rights reserved.
//

#import "NSString+ZLStringSize.h"

@implementation NSString (ZLStringSize)

- (CGSize)zl_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
    attr[NSFontAttributeName] = font;
    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    
}

- (CGSize)zl_stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    return [self zl_stringSizeWithFont:font maxWidth:maxWidth maxHeight:MAXFLOAT];
}

- (CGSize)zl_stringSizeWithFont:(UIFont *)font
{
    return [self zl_stringSizeWithFont:font maxWidth:MAXFLOAT maxHeight:MAXFLOAT];
}


@end
