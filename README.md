# WWActionSheet
iOS / Objective-C easy use ActionSheet

#可实现效果
![WWDashLineProject](https://github.com/alstonwei/WWActionSheet/blob/master/SCREENSHOT/01.png) 

#使用 
``` Objective-C
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
```


#联系我
    邮箱：wsq724439564@126.com 

    微博： http://weibo.com/u/1325583405 [@我就是大强]

    微信：shouqiang_Wei
