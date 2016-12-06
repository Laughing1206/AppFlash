
//
//  ToolBarView.m
//  APPFlash
//
//  Created by 李欢欢 on 2016/12/5.
//  Copyright © 2016年 Lihuanhuan. All rights reserved.
//

#import "ToolBarView.h"

@implementation ToolBarView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //收起键盘
    [textField resignFirstResponder];
    return YES;
}
@end
