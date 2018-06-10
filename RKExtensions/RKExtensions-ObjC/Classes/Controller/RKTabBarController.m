//
//  RKTabBarController.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "RKTabBarController.h"

@interface RKTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 9.0, *)) {
        self.forceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
}


// MARK: - Public Method

- (CGRect)barItemFrameWithIndex:(NSUInteger)index {
    if (index > self.tabBar.items.count-1) { return CGRectZero; }
    
    CGFloat flag = -1;
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            flag++;
            if (flag == index) {
                CGRect rect = [self.tabBar convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
                return rect;
            }
        }
    }
    
    return CGRectZero;
}



// MARK: - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (@available(iOS 10.0, *)) { // 线性马达触摸震动反馈
        [[[UISelectionFeedbackGenerator alloc] init] selectionChanged];
    }
}


@end


















