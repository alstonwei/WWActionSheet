//
//  UIView+Help.h
//  WWActionSheetSample
//
//  Created by alston on 2017/10/17.
//  Copyright © 2017年 @alston wei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WW_WINDOW [[[UIApplication sharedApplication] delegate] window]
#define isIpad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

@interface UIView (WWHelp)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic) CGPoint origin;

@property(nonatomic) CGSize size;

- (void)removeAllSubviews;

- (void)setOriginY:(CGFloat)originY;

- (void)setOriginX:(CGFloat)originx;

@end

@interface UIImage (FlatUI)

+ (UIImage *)resizableImageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width;

+ (UIImage *)roundCornerImageWithColor:(UIColor *)color width:(CGFloat)width;

@end

@interface UIButton (Extensions)

+ (instancetype)buttonWithType:(UIButtonType)type
                        target:(id)target
                        action:(SEL)action
                         image:(UIImage *)image
                highlightImage:(UIImage *)highlightImage;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (void)setTitleColor:(UIColor *)titleColor;

@end
