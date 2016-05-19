// ################################################################################//
//		文件名 : QCAutoLayoutViewController.m
// ################################################################################//
/*!
 @file		QCAutoLayoutViewController.m
 @brief		autolayout机制实现旋转的视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCAutoLayoutViewController.h"

@implementation QCAutoLayoutViewController

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}
#endif

@end
