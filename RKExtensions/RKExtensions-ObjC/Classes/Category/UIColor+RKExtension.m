//
//  UIColor+RKExtension.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/7/4.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "UIColor+RKExtension.h"

@implementation UIColor (RKExtension)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)randomColor {
    UInt32 upper = 255;
    CGFloat upperFloat = 255.0;
    
    return [UIColor colorWithRed:arc4random_uniform(upper)/upperFloat
                           green:arc4random_uniform(upper)/upperFloat
                            blue:arc4random_uniform(upper)/upperFloat
                           alpha:1];
}

@end
