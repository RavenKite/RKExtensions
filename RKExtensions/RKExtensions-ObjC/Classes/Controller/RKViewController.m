//
//  RKViewController.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "RKViewController.h"

@interface RKViewController ()

@property (nonatomic, strong) NSArray<NSString *> *frames;

@end

@implementation RKViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}



// MARK: - Public Method

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

// 返回导航栏分割线
- (UIView *)navigationBarSeparatorView {
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView *subview in view.subviews) {
                if (subview.bounds.size.height <= 1) {
                    return subview;
                }
            }
        }
    }
    return nil;
}

- (void)deviceOrientationDidChanged:(NSNotification *)noti {
    NSLog(@"need be override!");
}



// MARK: - Touch Action

/**
 * 以下方法的作用是用户点击不可编辑区域时自动收起键盘，因此为了保证该功能生效，
 * 子类如果重写了这个方法，请务必调用super
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    
    [self setKeyBoardResignRespondWith:touchPoint];
}


// MARK: - Private Method

- (void)handleSubviewsFrame {
    
    NSMutableArray *mAry = [NSMutableArray array];
    for (UIView *subview in self.view.subviews) {
        if ([subview conformsToProtocol:@protocol(UITextInput)]) {
            NSString *frameStr = NSStringFromCGRect(subview.frame);
            if (![mAry indexOfObject:frameStr]) {
                [mAry addObject:frameStr];
            }
        }
    }
    
    self.frames = mAry;
    
}

- (void)setKeyBoardResignRespondWith:(CGPoint)touchPoint {
    
    BOOL isContain = false;
    for (NSString *frameStr in self.frames) {
        CGRect rect = CGRectFromString(frameStr);
        if (CGRectContainsPoint(rect, touchPoint)) {
            isContain = true;
            break;
        }
    }
    
    if (!isContain) { [[[UIApplication sharedApplication] keyWindow] endEditing:true]; }
    
}


@end





















