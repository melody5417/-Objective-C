// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/14    MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
