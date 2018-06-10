//
//  RKLabel.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "RKLabel.h"

@implementation RKLabel

- (void)drawTextInRect:(CGRect)rect {
    
    CGRect drawRect = CGRectEqualToRect(self.textDrawInRect, CGRectZero) ? rect : self.textDrawInRect;
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(drawRect, self.textDrawRectInset)];
    
}

@end
