//
//  RKNavigationController.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PEPBaseNavigationControllerProtocol

@optional

/**
 是否需要禁用全屏侧滑返回（Pop）上一级页面手势: 可在需要禁用手势的页面实现该方法并返回false
 
 @return 返回false时将禁用全屏Pop手势。默认开启，会自动根据viewControllers的数量判断手势事件是否被执行
 */
- (BOOL)prefersFullscreenPopGesture;

@end


@interface RKNavigationController : UINavigationController<PEPBaseNavigationControllerProtocol>


@property (nonatomic, strong) UIImage *backItemImage;


@end
