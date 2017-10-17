//
//  UIView.h
//  WWActionSheetSample
//
//  Created by alston on 2017/10/17.
//  Copyright © 2017年 @alston. All rights reserved.
//
/*
 ************usage**********
 WWActionSheet* sheet = [[WWActionSheet alloc] initWithFrame:JD_WINDOW.bounds];
 [sheet addAction:({
 [WWSheetAction actionWithTitle:@"删除" handler:^(WWSheetAction * _Nullable action) {
 [sheet hide];
 }];
 })];
 [sheet addAction:({
 [WWSheetAction actionWithTitle:@"分享" handler:^(WWSheetAction * _Nullable action) {
 [sheet hideWithAnimation:NO];
 }];
 })];
 [sheet show];
 */

#import <UIKit/UIKit.h>
#import "UIView+WWHelp.h"

@class WWSheetAction;
typedef void (^WWSheetActionHandler)(WWSheetAction * _Nullable action);

@interface WWSheetAction : NSObject

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic,copy,readonly)WWSheetActionHandler handler;
@property (nonatomic, getter=isEnabled) BOOL enabled;

+ (instancetype _Nullable )actionWithTitle:(nullable NSString *)title
                                   handler:(WWSheetActionHandler _Nullable )handler;

@end

@interface WWActionSheet : UIView

@property (nonatomic, readonly) NSArray<WWSheetAction *> * _Nullable actions;

@property (nonatomic, readonly,getter=isShowing) BOOL showing;

@property (nonatomic,assign) BOOL autoDismiss;//default is YES;

- (void)addAction:(WWSheetAction *_Nullable)action;

- (void)show;

- (void)hide;

- (void)showWithAnimation:(BOOL)animated;

- (void)hideWithAnimation:(BOOL)animated;


@end
