//
//  UIView.m
//  WWActionSheetSample
//
//  Created by alston on 2017/10/17.
//  Copyright © 2017年 @alston. All rights reserved.
//

#import "WWActionSheet.h"

#define WWActionSheetAnimationDuration (0.3)
#define WWActionSheetItemFontSize (isIpad ? 21:14)
#define WWActionSheetItemHeight (isIpad ? 65:50)

NS_INLINE UIColor *UIColorFromRGB(NSInteger rgb) {
    return [UIColor colorWithRed:(((rgb & 0xFF0000) >> 16)/255.0) green:(((rgb & 0xFF00) >> 8)/255.0) blue:((rgb & 0xFF)/255.0) alpha:1.0];
}

@interface WWActionSheet()

@property (nonatomic,copy,readwrite) NSString *title;
@property (nonatomic,copy,readwrite)WWSheetActionHandler handler;

@end

@implementation WWSheetAction : NSObject

- (instancetype _Nullable )initWithTitle:(nullable NSString *)title handler:(WWSheetActionHandler)handler{
    if (self = [super init]) {
        handler = handler;
        _title = title;
    }
    return self;
}

+ (instancetype _Nullable )actionWithTitle:(nullable NSString *)title handler:(WWSheetActionHandler)handler{
    WWSheetAction* action = [[WWSheetAction alloc] initWithTitle:title handler:handler];
    return action;
}

@end

@interface WWActionSheetItem :UIButton

@property (nonatomic,strong) WWSheetAction* action;

- (instancetype)initWithFrame:(CGRect)frame
                       action:(WWSheetAction*)action;

@end

@implementation WWActionSheetItem

- (instancetype)initWithFrame:(CGRect)frame
                       action:(WWSheetAction*)action{
    if(self = [super initWithFrame:frame]){
        _action = action;
        [self setTitle:action.title forState:UIControlStateNormal];
        [self setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [self setBackgroundColor:UIColorFromRGB(0xEEEEEE) forState:UIControlStateHighlighted];
        self.titleLabel.font = [UIFont systemFontOfSize:WWActionSheetItemFontSize];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

@end

@interface WWActionSheet()

@property (nonatomic,strong) UIButton* overlayView;
@property (nonatomic,strong) UIView* bottomWrapper;
@property (nonatomic,readwrite) NSArray<WWSheetAction *> * _Nullable actions;
@property (nonatomic,readwrite,getter=isShowing) BOOL showing;

@end

@implementation WWActionSheet


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:WW_WINDOW.bounds]) {
        _autoDismiss = YES;
        self.backgroundColor = [UIColor clearColor];
        _overlayView = [[UIButton alloc] initWithFrame:self.bounds];
        [_overlayView addTarget:self action:@selector(_btnOverlayClicked:) forControlEvents:UIControlEventTouchUpInside];
        _overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        [self addSubview:_overlayView];
        
        _bottomWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0)];
        _bottomWrapper.backgroundColor = UIColorFromRGB(0xFFFFFF);
        [self addSubview:_bottomWrapper];
    }
    
    return self;
}

- (void)addAction:(WWSheetAction *_Nullable)action{
    NSAssert(!self.isShowing, @"acton sheet isshowing");
    if (action) {
        if (!self.actions) {
            self.actions = @[action];
        }else{
            NSMutableArray* arr = [NSMutableArray arrayWithArray:self.actions];
            [arr addObject:action];
            self.actions = arr.copy;
        }
    }
}

-(void)_layoutActionSheetHeight{
    while (self.bottomWrapper.subviews.count) {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
    _overlayView.frame  = self.bounds;
    for (int i=0;i<self.actions.count;i++) {
        WWSheetAction* action = self.actions[i];
        WWActionSheetItem* item = [[WWActionSheetItem alloc] initWithFrame:CGRectMake(0,i*WWActionSheetItemHeight, self.width,WWActionSheetItemHeight) action:action];
        [item setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
        [self.bottomWrapper addSubview:item];
        [item addTarget:self action:@selector(_btnItemActionClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i<(self.actions.count-1)) {
            UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, item.bottom-1, self.width, 1)];
            [line setBackgroundColor:UIColorFromRGB(0xEEEEEE)];
            [self.bottomWrapper addSubview:line];
        }
    }
    self.bottomWrapper.height = self.actions.count*WWActionSheetItemHeight;
}

- (void)_btnItemActionClicked:(WWActionSheetItem*)item{
    !item.action.handler?:item.action.handler(item.action);
    if (_autoDismiss) {
        [self hide];
    }
}

- (void)_btnOverlayClicked:(id)sender{
    if ([self bottomBarCanAutoDissmiss]) {
        [self hide];
    }
}

- (BOOL)bottomBarCanAutoDissmiss{
    return YES;
}

- (void)show{
    [self showWithAnimation:YES];
}

- (void)hide{
    [self hideWithAnimation:YES];
}

- (void)showWithAnimation:(BOOL)animated{
    [self _layoutActionSheetHeight];
    [WW_WINDOW addSubview:self];
    __weak typeof (self) weakSelf = self;
    void(^animation)() = ^(){
        weakSelf.showing = YES;
        weakSelf.overlayView.layer.shadowColor = [[UIColor blackColor] CGColor];
        weakSelf.overlayView.layer.shadowOffset = CGSizeMake(0, -2);
        weakSelf.overlayView.layer.shadowRadius = 5.0;
        weakSelf.overlayView.layer.shadowOpacity = 0.2;
        weakSelf.overlayView.alpha = 1.0;
        [weakSelf.bottomWrapper setOriginY:self.height - self.bottomWrapper.height];
    };
    
    if (animated) {
        [UIView animateWithDuration:WWActionSheetAnimationDuration animations:animation];
    }else{
        animation();
    }
    
}

- (void)hideWithAnimation:(BOOL)animated{
    
    __weak typeof (self) weakSelf = self;
    void(^animation)() = ^(){
        [weakSelf.bottomWrapper setOriginY:weakSelf.height];
        weakSelf.overlayView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
        weakSelf.overlayView.layer.shadowOffset = CGSizeZero;
        weakSelf.overlayView.layer.shadowRadius = 0.0;
        weakSelf.overlayView.layer.shadowOpacity = 0.0;
        weakSelf.overlayView.alpha = 0.0;
    };
    
    void(^completion)(BOOL finished) = ^(BOOL finished){
        weakSelf.showing = NO;
        [weakSelf removeFromSuperview];
    };
    
    
    if (animated) {
        [UIView animateWithDuration:WWActionSheetAnimationDuration animations:animation completion:completion];
    }else{
        animation();
        completion(YES);
    }
}

@end
