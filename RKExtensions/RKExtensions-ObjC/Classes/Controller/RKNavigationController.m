//
//  RKNavigationController.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "RKNavigationController.h"

@interface RKNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation RKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    [self replacePopGesture];
    
}

- (void)replacePopGesture {
    
    SEL sel = NSSelectorFromString(@"handleNavigationTransition:");
    
    if ([self.interactivePopGestureRecognizer.delegate respondsToSelector:sel]) {
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:sel];
        
        pan.delegate = self;
        
        [self.view addGestureRecognizer:pan];
    }
    
}


// MARK: - Action

- (void)backBarItemAction:(UIBarButtonItem *)sender {
    
    [self popViewControllerAnimated:true];
}


// MARK: - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([self respondsToSelector:@selector(prefersFullscreenPopGesture)]) {
        return [self prefersFullscreenPopGesture];
    }
    
    return self.viewControllers.count != 1;
}


// MARK: - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self configNavigationBarBackItem];
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}



// MARK: - Private Method

- (void)configNavigationBarBackItem {
    if (self.viewControllers.count < 2 || !self.backItemImage) { return; }
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:self.backItemImage style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemAction:)];
    
    self.topViewController.navigationItem.leftBarButtonItem = backItem;
}




@end














