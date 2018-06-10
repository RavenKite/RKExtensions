//
//  RKViewController.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKViewController : UIViewController

/**
 屏幕旋转方向发生变化时该方法将会被调用，此类中未实现该方法，子类可根据需要选择是否实现
 
 @param noti noti description
 */
- (void)deviceOrientationDidChanged:(NSNotification *)noti;

/**
 设置状态栏颜色: 如需改变页面的状态栏颜色，可通过该方法在viewWillAppear中设置，别忘记在viewWillDisappear中还原
 
 @param color 状态栏颜色
 */
- (void)setStatusBarBackgroundColor:(UIColor *)color;

/**
 返回导航栏分割线: 可用于控制隐藏和显示导航栏分割线
 
 @return return value description
 */
- (UIView *)navigationBarSeparatorView;


@end
