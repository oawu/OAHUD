//
//  ViewController.m
//  OAHUD
//
//  Created by OA Wu on 2015/7/9.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    OAHUD *oaHud;
}

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
- (IBAction)click1:(id)sender {
    [OAHUD show];
    [self performSelector:@selector(hideClick1) withObject:nil afterDelay:2.0f];
}
- (void)hideClick1 {
    [OAHUD hide];
}


- (IBAction)click2:(id)sender {
    oaHud = [OAHUD new];
    [oaHud setPanelViewDimension:50.0];
    [oaHud setLoadingDimension:30.0];
    [oaHud setLoadingWeight:2.0];
    [oaHud setColor:[UIColor colorWithRed:0.87 green:0.78 blue:0.36 alpha:1]];
    [oaHud setColorInfos:@[@{@"color":[UIColor colorWithRed:0.82 green:0.17 blue:0.11 alpha:1],
                             @"location":@0.0f},
                           @{@"color":[UIColor colorWithRed:0.85 green:0.76 blue:0.35 alpha:1],
                             @"location":@0.5f},
                           @{@"color":[UIColor colorWithRed:0.18 green:0.53 blue:0.09 alpha:1],
                             @"location":@1.0f}]];

    [oaHud show];
    [self performSelector:@selector(hideClick2) withObject:nil afterDelay:2.0f];
}
- (void)hideClick2 {
    [oaHud hide];
}

@end
