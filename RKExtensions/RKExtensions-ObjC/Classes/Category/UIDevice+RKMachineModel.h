//
//  UIDevice+RKMachineModel.h
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/10/31.
//  Copyright © 2018 peizhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (RKMachineModel)

/**设备具体型号。例如：iPhone 6s、iPad Air*/
@property (nonatomic, copy, readonly) NSString *machineModel;

/**内部型号。例如iPhone9,1*/
@property (nonatomic, copy, readonly) NSString *internalModel;

/**存储版本。例如：32GB、128GB*/
@property (nonatomic, copy, readonly) NSString *storage;

/**存储空间总大小。以MB为单位*/
@property (nonatomic, assign, readonly) CGFloat totalDiskSpace;

/**存储空间可用大小。以MB为单位*/
@property (nonatomic, assign, readonly) CGFloat freeDiskSpace;

/**系统内存(RAM)。例如：2GB*/
@property (nonatomic, copy, readonly) NSString *memory;

/**运营商信息。例如：中国移动*/
@property (nonatomic, copy, readonly) NSString *telephonyInfo;

/**
 设备前面板颜色
 iPhone 7: 1为前面板黑色, 2为前面板白色
 iPhone 6s: #e4e7e8(白色)
 iPad pro 12.9: #e1e4e3(白色)
 */
@property (nonatomic, copy, readonly) NSString *deviceColor;

/**
 设备背板颜色
 iPhone 7: 1为磨砂黑, 3为金色, 4为玫瑰金
 iPhone 6s: #dadcdb(银色)
 iPad pro 12.9: #e1ccb5(金色)
 */
@property (nonatomic, copy, readonly) NSString *deviceEnclosureColor;

@end

NS_ASSUME_NONNULL_END
