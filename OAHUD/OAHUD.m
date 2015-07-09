//
//  OAHUD.m
//  OAHUD
//
//  Created by OA Wu on 2015/7/9.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "OAHUD.h"

@implementation OAHUD



@synthesize panelViewDimension, loadingDimension, loadingWeight, colorInfos, color;



+ (UIWindow *)window {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.backgroundColor = [UIColor clearColor];
        objc_setAssociatedObject(self, @selector(window), window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}
+ (void)show {
    [OAHUD show:[OAHUD new]];
}
+ (void)show:(OAHUD *)hud {
    [[OAHUD window] setRootViewController:hud];
    [[OAHUD window] makeKeyAndVisible];
}
+ (void)hide {
    [[OAHUD window].rootViewController performSelector:@selector(runHideAnimate:) withObject: ^{
        [OAHUD window].hidden = YES;
        objc_setAssociatedObject(self, @selector(window), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[UIApplication sharedApplication].keyWindow makeKeyWindow];
    }];
}



- (void)show {
    [OAHUD show:self];
}
- (void)hide {
    [OAHUD hide];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOption];
    
    [self initVisualEffectView];
    [self initPanelView];
    [self initLoadingView1];
    [self initLoadingView2];
    
    [self runShowAnimate];
}
- (void)initOption {
    if (!self.panelViewDimension)
        [self setPanelViewDimension:100.0];
    
    if (!self.loadingDimension)
        [self setLoadingDimension:70.0];
    
    if (!self.loadingWeight)
        [self setLoadingWeight:5.0];
    
    if ((self.loadingDimension > self.panelViewDimension) || (self.loadingDimension < 1) || ((self.loadingDimension - (self.loadingWeight * 2)) < 1))
        [self setPanelViewDimension:self.loadingDimension];
    
    if ((self.loadingDimension - (self.loadingWeight * 2)) < 1)
        [self setLoadingWeight:self.loadingDimension / 4];
    
    if (!self.colorInfos)
        [self setColorInfos:@[@{@"color":[UIColor colorWithRed:0.99 green:0.36 blue:0.32 alpha:1],
                                @"location":@0.0f},
                              @{@"color":[UIColor colorWithRed:0.16 green:0.76 blue:0.99 alpha:1],
                                @"location":@1.0f}]];
    if (!self.color)
        [self setColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1]];
}
- (void)runShowAnimate {
    float time = 0.5;
    __weak OAHUD *wealSelf = self;
    
    wealSelf.view.alpha = 1.0f;
    wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    
    [UIView animateWithDuration:time * 0.5 animations: ^{
        wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion: ^(BOOL finished) {
        [UIView animateWithDuration:time * 0.1 animations: ^{
            wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.96, 0.96);
        } completion: ^(BOOL finished) {
            [UIView animateWithDuration:time * 0.08 animations: ^{
                wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.02, 1.02);
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:time * 0.05 animations: ^{
                    wealSelf.panelView.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
    }];
}
- (void)runHideAnimate:(void (^)(void))completion {
    float time = 0.5;
    __weak OAHUD *wealSelf = self;
    
    wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    
    [UIView animateWithDuration:time * 0.05 animations: ^{
        wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.02, 1.02);
    } completion: ^(BOOL finished) {
        [UIView animateWithDuration:time * 0.08 animations: ^{
            wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.96, 0.96);
        } completion: ^(BOOL finished) {
            [UIView animateWithDuration:time * 0.1 animations: ^{
                wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
            } completion: ^(BOOL finished) {
                [UIView animateWithDuration:time * 0.5 animations: ^{
                    wealSelf.view.alpha = 0.0f;
                    wealSelf.panelView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                } completion:^(BOOL finished) {
                    completion();
                }];
            }];
        }];
    }];
}
- (void)initVisualEffectView {
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.visualEffectView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.visualEffectView setOpaque:NO];
    [self.view addSubview:self.visualEffectView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.visualEffectView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.visualEffectView superview]
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.visualEffectView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.visualEffectView superview]
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.visualEffectView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.visualEffectView superview]
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.visualEffectView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.visualEffectView superview]
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.visualEffectView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.visualEffectView superview]
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.visualEffectView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.visualEffectView superview]
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0.0]];
}
- (void)initPanelView {
    self.panelView = [UIView new];
    [self.panelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.panelView setBackgroundColor:self.color];
    [self.panelView.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.panelView.layer setBorderWidth:3.5f / [UIScreen mainScreen].scale];
    [self.panelView.layer setCornerRadius:10.0f];
    [self.panelView setClipsToBounds:YES];
    [self.view addSubview:self.panelView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.panelView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.panelView superview]
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.panelView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:[self.panelView superview]
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.panelView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:self.panelViewDimension]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.panelView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:self.panelViewDimension]];
}
- (void)initLoadingView1 {
    self.loadingView1 = [UIView new];
    [self.loadingView1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loadingView1.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.loadingView1.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.loadingView1.layer setCornerRadius:self.loadingDimension / 2];
    [self.loadingView1 setClipsToBounds:YES];
    [self.panelView addSubview:self.loadingView1];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView1
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:[self.loadingView1 superview]
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0
                                                                constant:0.0]];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView1
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:[self.loadingView1 superview]
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0]];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView1
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:self.loadingDimension]];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView1
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:self.loadingDimension]];
    
    CAGradientLayer *bgLayer = [self colorGradient];
    bgLayer.frame = CGRectMake(0, 0, self.loadingDimension, self.loadingDimension);
    [self.loadingView1.layer insertSublayer:bgLayer atIndex:0];
    
    if ([self.loadingView1.layer animationForKey:@"SpinAnimation"] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        [animation setFromValue:[NSNumber numberWithFloat:0.0f]];
        [animation setToValue:[NSNumber numberWithFloat: 2 * M_PI]];
        [animation setDuration:1.0f];
        [animation setRepeatCount:INFINITY];
        
        [self.loadingView1.layer addAnimation:animation forKey:@"SpinAnimation"];
    }
}
- (void)initLoadingView2 {
    self.loadingView2 = [UIView new];
    [self.loadingView2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loadingView2 setBackgroundColor:self.color];
    [self.loadingView2.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.loadingView2.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.loadingView2.layer setCornerRadius:(self.loadingDimension - (self.loadingWeight * 2)) / 2];
    [self.loadingView2 setClipsToBounds:YES];
    [self.panelView addSubview:self.loadingView2];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView2
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:[self.loadingView2 superview]
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0
                                                                constant:0.0]];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView2
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:[self.loadingView2 superview]
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0]];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView2
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:self.loadingDimension - self.loadingWeight * 2]];
    
    [self.panelView addConstraint:[NSLayoutConstraint constraintWithItem:self.loadingView2
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:self.loadingDimension - (self.loadingWeight * 2)]];
}

- (CAGradientLayer*)colorGradient {
    NSMutableArray *colors = [NSMutableArray new];
    for (id colorInfo in self.colorInfos)
        [colors addObject:(id)((UIColor *)[colorInfo objectForKey:@"color"]).CGColor];
    
    NSMutableArray *locations = [NSMutableArray new];
    for (id colorInfo in self.colorInfos)
        [locations addObject:[colorInfo objectForKey:@"location"]];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
