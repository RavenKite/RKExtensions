//
//  RKTextField.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKTextField : UITextField

/**
 TextField中的文字需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets textRectInsets;


/**
 placeholder中的文字需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets placeholderRectInsets;


/**
 编辑区域需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets editingRectInsets;


/**
 清除按钮需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets clearButtonRectInsets;


/**
 leftView需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets leftViewRectInsets;


/**
 rightView需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets rightViewRectInsets;


/**
 文本绘制区域，默认跟随系统设置
 */
@property (nonatomic, assign) CGRect textDrawInRect;


/**
 placeholder绘制区域，默认跟随系统设置
 */
@property (nonatomic, assign) CGRect placeholderDrawInRect;

@end










