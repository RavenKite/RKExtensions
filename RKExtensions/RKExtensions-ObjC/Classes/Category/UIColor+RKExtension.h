//
//  UIColor+RKExtension.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/7/4.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RKExtension)


/**
 通过16进制色值构造UIColor

 @param hex 形如 0xffffff 的16进制色值
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;


/**
 随机色
 */
+ (UIColor *)randomColor;

@end
