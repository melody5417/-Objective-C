// ################################################################################//
//		文件名 : QCCustomAccessbilityViewController.m
// ################################################################################//
/*!
 @file		QCCustomAccessbilityViewController.m
 @brief		自定义控件实现辅助功能的控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomAccessbilityViewController.h"
#import "QCCustomView.h"

@interface QCCustomAccessbilityViewController ()
@property (nonatomic, retain) IBOutlet QCCustomView   *mainView;
@end

@implementation QCCustomAccessbilityViewController
@synthesize mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //导航栏的标题
    self.title = @"自定义控件辅助功能";
}

@end
