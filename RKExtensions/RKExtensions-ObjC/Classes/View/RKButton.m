//
//  RKButton.m
//  StarView
//
//  Created by 李沛倬 on 2018/5/19.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "RKButton.h"

static CGFloat const margin = 5;

typedef void(^ControlEventBlock)(void);


@interface RKButton()

@property (nonatomic, copy) ControlEventBlock touchDown;

@property (nonatomic, copy) ControlEventBlock touchDownRepeat;

@property (nonatomic, copy) ControlEventBlock touchDragInside;

@property (nonatomic, copy) ControlEventBlock touchDragOutside;

@property (nonatomic, copy) ControlEventBlock touchDragEnter;

@property (nonatomic, copy) ControlEventBlock touchDragExit;

@property (nonatomic, copy) ControlEventBlock touchUpInside;

@property (nonatomic, copy) ControlEventBlock touchUpOutside;

@property (nonatomic, copy) ControlEventBlock touchCancel;


@end

@implementation RKButton


// MARK: - Public Method

- (void)touchActionForControlEvents:(UIControlEvents)controlEvent actionBlock:(void(^)(void))block {
    if (!block) { return; }
    
    SEL sel = NULL;
    
    switch (controlEvent) {
        case UIControlEventTouchDown: {
            sel = @selector(touchDown:);
            self.touchDown = block;
            break;
        }
        case UIControlEventTouchDownRepeat: {
            sel = @selector(touchDownRepeat:);
            self.touchDownRepeat = block;
            break;
        }
        case UIControlEventTouchDragInside: {
            sel = @selector(touchDragInside:);
            self.touchDragInside = block;
            break;
        }
        case UIControlEventTouchDragOutside: {
            sel = @selector(touchDragOutside:);
            self.touchDragOutside = block;
            break;
        }
        case UIControlEventTouchDragEnter: {
            sel = @selector(touchDragEnter:);
            self.touchDragEnter = block;
            break;
        }
        case UIControlEventTouchDragExit: {
            sel = @selector(touchDragExit:);
            self.touchDragExit = block;
            break;
        }
        case UIControlEventTouchUpInside: {
            sel = @selector(touchUpInside:);
            self.touchUpInside = block;
            break;
        }
        case UIControlEventTouchUpOutside: {
            sel = @selector(touchUpOutside:);
            self.touchUpOutside = block;
            break;
        }
        case UIControlEventTouchCancel: {
            sel = @selector(touchCancel:);
            self.touchCancel = block;
            break;
        }
        default: {
            break;
        }
    }
    
    __weak typeof(self) weakSelf = self;
    [self addTarget:weakSelf action:sel forControlEvents:controlEvent];
    
}

// MARK: - Override

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.hidden) { return; }
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        return;
    }
    
    switch (self.layoutType) {
        case RKButtonLayoutTypeImageLeft: {
            break;
        }
        case RKButtonLayoutTypeImageRgiht: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width*2-margin, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -titleSize.width*2-margin);
            break;
        }
        case RKButtonLayoutTypeImageTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -imageSize.height-margin, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height-margin, 0, 0, -titleSize.width);
            break;
        }
        case RKButtonLayoutTypeImageBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageSize.height-margin, -imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -titleSize.height-margin, -titleSize.width);
            break;
        }
    }
    
}



// MARK: - Private Method

- (void)touchDown:(RKButton *)sender {
    
    if (self.touchDown) {
        self.touchDown();
    }
}

- (void)touchDownRepeat:(RKButton *)sender {
    
    if (self.touchDownRepeat) {
        self.touchDownRepeat();
    }
}

- (void)touchDragInside:(RKButton *)sender {
    
    if (self.touchDragInside) {
        self.touchDragInside();
    }
}

- (void)touchDragOutside:(RKButton *)sender {
    
    if (self.touchDragOutside) {
        self.touchDragOutside();
    }
}

- (void)touchDragEnter:(RKButton *)sender {
    
    if (self.touchDragEnter) {
        self.touchDragEnter();
    }
}

- (void)touchDragExit:(RKButton *)sender {
    
    if (self.touchDragExit) {
        self.touchDragExit();
    }
}

- (void)touchUpInside:(RKButton *)sender {
    
    if (self.touchUpInside) {
        self.touchUpInside();
    }
}

- (void)touchUpOutside:(RKButton *)sender {
    
    if (self.touchUpOutside) {
        self.touchUpOutside();
    }
}

- (void)touchCancel:(RKButton *)sender {
    
    if (self.touchCancel) {
        self.touchCancel();
    }
}



@end




























