
//
//  NavigationController.m
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

// 当类第一次被加载的时调用
+ (void)initialize
{
    // 取出导航条item的外观对象(主题对象)
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    // 设置默认状态文字的颜色
    NSMutableDictionary * md = [NSMutableDictionary dictionary];
    NSMutableDictionary * higMd = [NSMutableDictionary dictionary];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    md[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.f];
    higMd[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:md forState:UIControlStateNormal];
    [item setTitleTextAttributes:higMd forState:UIControlStateHighlighted];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.titleTextAttributes = md;
    bar.barTintColor = [UIColor colorWithRed:0.984 green:0.663 blue:0.153 alpha:1.000];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //屏幕左边缘右划返回功能
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = (id)self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
