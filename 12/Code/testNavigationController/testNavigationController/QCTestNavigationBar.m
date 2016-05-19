// ################################################################################//
//		文件名 : QCTestNavigationBar.m
// ################################################################################//
/*!
 @file		QCTestNavigationBar.m
 @brief		自定义导航栏实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCTestNavigationBar.h"

@implementation QCTestNavigationBar

//对于导航栏的自定义内容都可以放在此重画函数中
- (void)drawRect:(CGRect)rect {
    //为导航栏设置一个橙色的背景
    self.backgroundColor = [UIColor colorWithRed:145.0f/255.0f
                                           green:190.0f/255.0f
                                            blue:5.0f/255.0f
                                           alpha:1.0f];
}

@end
