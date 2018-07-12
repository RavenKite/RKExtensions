//
//  UIImage+RKExtension.m
//  DrawerArch
//
//  Created by 李沛倬 on 2017/5/9.
//  Copyright © 2017年 pep. All rights reserved.
//

#import "UIImage+RKExtension.h"
#import "RKExtensionHeader.h"
#import "UIColor+RKExtension.h"

#define SCREENSCALE [UIScreen mainScreen].scale

@implementation UIImage (RKExtension)

#pragma mark - Class Methods
+ (UIImage *)arcImageWithAngle:(CGFloat)angle radius:(CGFloat)radius backgroundColor:(UIColor *)color {
    CGFloat height = 2 * radius * cos(M_PI_2 - angle / 2);
    CGSize size = CGSizeMake(radius+2, height);
    CGSize center = CGSizeMake(size.width, height/2);
    
    UIGraphicsBeginImageContextWithOptions(size, false, 3);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.width, center.height);
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextAddLineToPoint(context, size.width - sqrt(pow(radius, 2)-pow(height/2, 2)), height);
    CGContextAddArc(context, center.width, center.height, radius, M_PI-angle/2, M_PI+angle/2, false);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, true, SCREENSCALE);
    CGContextRef contenxt = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contenxt, color.CGColor);
    CGContextFillRect(contenxt, fillRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)fullScreenshot {
    return [self imageWithView:[UIApplication sharedApplication].keyWindow];
}

+ (UIImage *)screenshotWithView:(UIView *)view {
    return [self imageWithView:view];
}


+ (UIImage *)screenshotWithView:(UIView *)view rect:(CGRect)rect {
    UIImage *image = [self imageWithView:view];
    
    CGRect scaleRect = CGRectScale(rect, SCREENSCALE);
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, scaleRect);
    
    UIImage *screenshotImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return screenshotImage;
}


#pragma mark - Private Methods
+ (UIImage *)imageWithView:(UIView *)view {
    UIImage *image = [[UIImage alloc] init];
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, true, SCREENSCALE);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextFillRect(context, view.bounds);
    [view.layer renderInContext:context];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Instance Methods
- (UIImage *)zoomImageWithScale:(CGFloat)scale {
    CGSize newSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
    UIImage *zoomImage = self;
    
    zoomImage = [self resizeImageWithNewSize:newSize];
    
    return zoomImage;
}

- (UIImage *)resizeImageWithNewSize:(CGSize)newSize {
    UIImage *newImage = self;
    
    UIGraphicsBeginImageContextWithOptions(newSize, true, SCREENSCALE);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)cropImageWithRect:(CGRect)rect {
    UIImage *newImage = self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, true, SCREENSCALE);
    CGImageRef cgImage = CGImageCreateWithImageInRect(self.CGImage, rect);
    newImage = [UIImage imageWithCGImage:cgImage scale:self.scale orientation:self.imageOrientation];
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end











