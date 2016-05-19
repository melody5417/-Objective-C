// ################################################################################//
//		文件名 : QCTabbarController.m
// ################################################################################//
/*!
 @file		QCTabbarController.m
 @brief		作为程序根视图的TabbarController实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCTabbarController.h"

@implementation QCTabbarController

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return YES;
}

@end
