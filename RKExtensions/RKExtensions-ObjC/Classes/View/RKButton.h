//
//  RKButton.h
//  StarView
//
//  Created by 李沛倬 on 2018/5/19.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, RKButtonLayoutType) {
    RKButtonLayoutTypeImageLeft,            /// 系统默认状态，图片在左，文字在右
    RKButtonLayoutTypeImageRgiht,           /// 图片在右，文字在左
    RKButtonLayoutTypeImageTop,             /// 图片在上，文字在下
    RKButtonLayoutTypeImageBottom,          /// 图片在下，文字在上
};


@interface RKButton : UIButton


@property (nonatomic, assign) RKButtonLayoutType layoutType;


/**
 UIButton Block Action

 @param controlEvent UIControlEvents. only support: UIControlEventTouchDown ~ UIControlEventTouchCancel
 @param block Action Block
 */
- (void)touchActionForControlEvents:(UIControlEvents)controlEvent actionBlock:(void(^)(void))block;


@end












