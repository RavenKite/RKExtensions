//
//  RKLabel.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKLabel : UILabel

/**
 Label中的文字需要缩进的范围，如果不设置将使用系统默认样式。
 */
@property (nonatomic, assign) UIEdgeInsets textDrawRectInset;


/**
 Label中的文字绘制范围，如果不设置将使用self.bounds
 如果textDrawInRect和textDrawRectInset同时设置，将根据基于textDrawInRect缩进textDrawRectInset得到的Rect来确定绘制范围
 */
@property (nonatomic, assign) CGRect textDrawInRect;


@end
