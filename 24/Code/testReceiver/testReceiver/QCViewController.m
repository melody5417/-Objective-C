// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@implementation QCViewController

#pragma mark -
#pragma mark Interface
-(void)printLog:(NSString*)aNewLog
{
    self.textView.text = [self.textView.text stringByAppendingString:@"\n----------------------------"];
    self.textView.text = [self.textView.text stringByAppendingString:aNewLog];
}

@end
