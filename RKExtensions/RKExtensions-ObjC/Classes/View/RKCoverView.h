//
//  RKCoverView.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/7/4.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RKCoverViewType) {
    RKCoverViewTypeRandom,
    RKCoverViewTypeClockwise,
    RKCoverViewTypeAnticlockwise,
    RKCoverViewTypeUpToDown,
    RKCoverViewTypeLeftToRight,
    RKCoverViewTypeCenterToSide,
    RKCoverViewTypeSideToCenter,
    RKCoverViewTypeGradient,
};


@interface RKCoverView : UIView

@property (nonatomic, assign) RKCoverViewType coverType;

/** 0~1 */
@property (nonatomic, assign) CGFloat coverAlpha;


@property (nonatomic, strong, readonly) UILabel *textLabel;



@end


























