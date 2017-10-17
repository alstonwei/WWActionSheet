//
//  ViewController.m
//  WWActionSheetSample
//
//  Created by alston on 2017/10/17.
//  Copyright © 2017年 @alston wei. All rights reserved.
//

#import "ViewController.h"
#import "WWActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTestClicked:(id)sender {
    WWActionSheet* sheet = [[WWActionSheet alloc] initWithFrame:WW_WINDOW.bounds];
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
    [sheet addAction:({
        [WWSheetAction actionWithTitle:@"TEST 1" handler:^(WWSheetAction * _Nullable action) {
            [sheet hide];
        }];
    })];
    [sheet addAction:({
        [WWSheetAction actionWithTitle:@"TEST 2" handler:^(WWSheetAction * _Nullable action) {
            [sheet hide];
        }];
    })];
    [sheet addAction:({
        [WWSheetAction actionWithTitle:@"TEST 3" handler:^(WWSheetAction * _Nullable action) {
            [sheet hide];
        }];
    })];
    [sheet show];
}

@end
