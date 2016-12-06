//
//  GuideViewControrller.m
//  APPFlash
//
//  Created by 李欢欢 on 2016/12/5.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "GuideViewControrller.h"
#import "RootViewController.h"
#import "AppDelegate.h"
@interface GuideViewControrller ()
@property (weak, nonatomic) IBOutlet UIImageView * imageView;
@property (weak, nonatomic) IBOutlet UIView * bgView;
@property (weak, nonatomic) IBOutlet UIImageView * logoImg;

@end

@implementation GuideViewControrller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = self.imageView.bounds;
    
    [self.imageView addSubview:visualEffectView];
    self.bgView.alpha = 0;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            
            self.bgView.alpha = 1;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1 animations:^{
                
                for ( UIView * subview in self.imageView.subviews )
                {
                    if ( [subview isKindOfClass:[UIVisualEffectView class]] )
                    {
                        subview.alpha = 0;
                    }
                }
                
                self.logoImg.alpha = 0;
                self.bgView.alpha = 0;
            } completion:^(BOOL finished) {
                
                
                for ( UIView * subview in self.imageView.subviews )
                {
                    if ( [subview isKindOfClass:[UIVisualEffectView class]] )
                    {
                        [subview removeFromSuperview];
                    }
                }
                [self.logoImg removeFromSuperview];
                [self.bgView removeFromSuperview];
                
                AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                appDelegate.window.rootViewController = [[RootViewController alloc] init];
                
            }];
            
        }];
    });
}

@end
