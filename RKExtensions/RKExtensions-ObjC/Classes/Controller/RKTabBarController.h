//
//  RKTabBarController.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKTabBarController : UITabBarController


/** 是否支持ForceTouch(3D Touch) */
@property (nonatomic, assign) BOOL forceTouchAvailable;

/**
 获取指定barItem的frame

 @param index barItem下标
 @return barItem frame
 */
- (CGRect)barItemFrameWithIndex:(NSUInteger)index;


@end
