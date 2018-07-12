//
//  RKExtensionHeader.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/7/4.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#ifndef RKExtensionHeader_h
#define RKExtensionHeader_h

/**
 根据起点坐标和尺寸构建CGRect
 
 @param origin 起点坐标（CGPoint）
 @param size 宽高尺寸（CGSize）
 @return CGRect
 */
CG_INLINE CGRect CGRectWith(CGPoint origin, CGSize size) {
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

/**
 将传入的rect按照scale倍数进行缩放。
 注意：起点坐标也会跟随缩放
 
 @param rect 需要缩放的原始rect
 @param scale 缩放倍数，小于0时将返回CGRectZero
 @return 缩放后的rect
 */
CG_INLINE CGRect CGRectScale(CGRect rect, CGFloat scale) {
    if (scale <= 0 ) { return CGRectZero; }
    return CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
}

/**
 通过两个坐标点构建出两点所构成的矩形：两点中最小的x、y坐标为起点，两点横纵坐标的绝对值为size
 
 @param point1 point1 description
 @param point2 point2 description
 @return CGRect
 */
CG_INLINE CGRect CGRectMakePoint(CGPoint point1, CGPoint point2) {
    return CGRectMake(MIN(point1.x, point2.x), MIN(point1.y, point2.y), fabs(point1.x-point2.x), fabs(point1.y-point2.y));
}



#endif /* RKExtensionHeader_h */














