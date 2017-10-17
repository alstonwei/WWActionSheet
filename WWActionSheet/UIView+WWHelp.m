//
//  UIView+Help.m
//  WWActionSheetSample
//
//  Created by alston on 2017/10/17.
//  Copyright © 2017年 @alston wei. All rights reserved.
//

#import "UIView+WWHelp.h"

@implementation UIView (WWHelp)

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (void)setOriginX:(CGFloat)originx {
    CGRect frame = self.frame;
    frame.origin.x = originx;
    self.frame = frame;
}


- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end

@implementation UIImage (FlatUI)

+ (UIImage *)resizableImageWithColor:(UIColor *)color {
    UIImage *img = [self imageWithColor:color width:1];
    return [img resizableImageWithCapInsets:UIEdgeInsetsZero];
}

+ (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width {
    CGRect rect = CGRectMake(0, 0, width, width);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)roundCornerImageWithColor:(UIColor *)color width:(CGFloat)width {
    CGRect rect = CGRectMake(0, 0, width, width);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width/2.0];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddPath(context, path.CGPath);
    CGContextClosePath(context);
    CGContextClip(context);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIButton (Extensions)

+ (instancetype)buttonWithType:(UIButtonType)type
                        target:(id)target
                        action:(SEL)action
                         image:(UIImage *)image
                highlightImage:(UIImage *)highlightImage
{
    UIButton *button = [UIButton buttonWithType:type];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:image
            forState:UIControlStateNormal];
    
    [button setImage:highlightImage
            forState:UIControlStateHighlighted];
    
    return button;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIImage resizableImageWithColor:backgroundColor] forState:state];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)horizontallyCenterImageAndTextWithSpacing:(CGFloat)spacing
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, -spacing);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing); // fix autolayout bug http://stackoverflow.com/a/28287773
}

- (void)verticallyCenterImageAndTextWithSpacing:(CGFloat)spacing
{
    CGSize  imageSize = self.currentImage.size;
    CGFloat imageMargin = (self.bounds.size.width - imageSize.width) / 2.0;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, imageMargin, self.bounds.size.height - imageSize.height, imageMargin);
    self.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height + spacing, -imageSize.width, 0.0, 0.0);
}

@end
