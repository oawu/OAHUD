//
//  OAHUD.h
//  OAHUD
//
//  Created by OA Wu on 2015/7/9.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface OAHUD : UIViewController

@property UIVisualEffectView *visualEffectView;
@property UIView *panelView;

@property UIView *loadingView1;
@property UIView *loadingView2;

@property CGFloat panelViewDimension;
@property CGFloat loadingDimension;
@property CGFloat loadingWeight;
@property NSArray *colorInfos;
@property UIColor *color;

+ (void)show;
+ (void)hide;

- (void)show;
- (void)hide;

@end
