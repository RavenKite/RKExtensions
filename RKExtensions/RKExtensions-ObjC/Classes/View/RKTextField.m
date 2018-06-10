//
//  RKTextField.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "RKTextField.h"

@implementation RKTextField

// MARK: - Override

- (CGRect)textRectForBounds:(CGRect)bounds {
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.textRectInsets, UIEdgeInsetsZero)) {
        return [super textRectForBounds:bounds];
    }
    
    return UIEdgeInsetsInsetRect(bounds, self.textRectInsets);
}


- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.placeholderRectInsets, UIEdgeInsetsZero)) {
        return [super placeholderRectForBounds:bounds];
    }
    
    return UIEdgeInsetsInsetRect(bounds, self.placeholderRectInsets);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
    
    if (UIEdgeInsetsEqualToEdgeInsets(self.editingRectInsets, UIEdgeInsetsZero)) {
        return [super editingRectForBounds:bounds];
    }
    
    return UIEdgeInsetsInsetRect(bounds, self.editingRectInsets);
    
}


- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    
    CGRect newBounds = UIEdgeInsetsInsetRect(bounds, self.clearButtonRectInsets);
    
    return [super clearButtonRectForBounds:newBounds];
    
}


- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect newBounds = UIEdgeInsetsInsetRect(bounds, self.leftViewRectInsets);
    
    return [super leftViewRectForBounds:newBounds];
    
}


- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    
    CGRect newBounds = UIEdgeInsetsInsetRect(bounds, self.rightViewRectInsets);
    
    return [super rightViewRectForBounds:newBounds];
    
}

- (void)drawTextInRect:(CGRect)rect {
    
    if (CGRectEqualToRect(self.textDrawInRect, CGRectZero)) {
        [super drawTextInRect:rect];
    } else {
        [super drawTextInRect:self.textDrawInRect];
    }
    
}


- (void)drawPlaceholderInRect:(CGRect)rect {
    
    if (CGRectEqualToRect(self.placeholderDrawInRect, CGRectZero)) {
        [super drawPlaceholderInRect:rect];
    } else {
        [super drawPlaceholderInRect:self.placeholderDrawInRect];
    }
    
}

@end
