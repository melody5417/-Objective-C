// ################################################################################//
//		文件名 : QCNavigationController.m
// ################################################################################//
/*!
 @file		QCNavigationController.m
 @brief		程序根视图的导航控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCNavigationController.h"

@implementation QCNavigationController

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return [self.topViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

#pragma mark -
#pragma mark iOS6.0 later
-(NSUInteger)supportedInterfaceOrientations{
    //根据当前具体视图控制器，决定是否支持旋转方向
    return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate {
    //根据当前具体视图控制器，决定是否支持旋转
    return [self.topViewController shouldAutorotate];
}

@end
