//
//  OneViewController.m
//  AppFlash
//
//  Created by 李欢欢 on 2016/12/6.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "OneViewController.h"
#import "ToolBarView.h"
#import "UIView+Extension.h"
#import "ADScrollView.h"

@interface OneViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) ADScrollView * scrollView;
@property (nonatomic, strong) ToolBarView *barView;

@end

@implementation OneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self setupToolBarView];
    [self hideTabBar];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showTabBar];
    });
    
}

- (void)setupToolBarView
{
    self.barView = [[[NSBundle mainBundle] loadNibNamed:@"ToolBarView" owner:nil options:nil] lastObject];
    
    self.barView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64.f);
    [self.view addSubview:self.barView];
}

- (void)setupTableView
{
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource      = self;
    self.tableView.delegate        = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 49, 0);
    [self.view addSubview:self.tableView];
    
    self.scrollView = [[ADScrollView alloc]initWithFrame:CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width, 200)];
    
    [self.tableView addSubview:self.scrollView];
    
    self.scrollView.imageClickBlock = ^(NSInteger index)
    {
        NSLog(@"%ld",index);
    };
    self.scrollView.time = 3;
    UIImage * image1 = [UIImage imageNamed:@"lead-640-1136-pic01"];
    UIImage * image2 = [UIImage imageNamed:@"lead-640-1136-pic02"];
    UIImage * image3 = [UIImage imageNamed:@"lead-640-1136-pic03"];
    self.scrollView.imageArray = @[image1, image2, image3];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.0001f;
}

- (void)hideTabBar
{
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
    [self.tableView setContentOffset:CGPointMake(0, -[UIScreen mainScreen].bounds.size.height - 20) animated:NO];
    self.barView.top = -64.f;
}

- (void)showTabBar
{
    [self.tableView setContentOffset:CGPointMake(0, -200) animated:YES];
    
    [UIView animateWithDuration:1 animations:^{
        
        self.barView.top = 0.f;
    }];
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( scrollView == self.tableView )
    {
        CGFloat y = scrollView.contentOffset.y; //如果有导航控制器，这里应该加上导航控制器的高度64
        
        if (y< - 200) {
            
            CGRect frame = self.scrollView.frame;
            
            frame.origin.y = y;
            
            frame.size.height = -y;
            
            self.scrollView.frame = frame;
            
        }
    }
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.barView.height = 64.f;
}
@end
