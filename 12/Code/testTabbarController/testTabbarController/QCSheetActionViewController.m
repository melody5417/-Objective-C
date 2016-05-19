// ################################################################################//
//		文件名 : QCSheetActionViewController.m
// ################################################################################//
/*!
 @file		QCSheetActionViewController.m
 @brief		TabbarController的第二个视图控制器：“弹出警告框”
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSheetActionViewController.h"

@implementation QCSheetActionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Tabbar图标
        self.tabBarItem.image = [UIImage imageNamed:@"test"];
        
        //Tabbar标题
        self.title = @"警告框";
    }
    return self;
}

#pragma mark -
#pragma mark Action
- (IBAction)actShowSheet:(id)sender
{
    UIActionSheet   *sheet = [[[UIActionSheet alloc] initWithTitle:@"测试警告框"
                                                         delegate:nil
                                                cancelButtonTitle:@"取消"
                                           destructiveButtonTitle:@"重要按钮"
                                                 otherButtonTitles:nil] autorelease];
    //最关键的一句话
    //可以避免Sheet显示时层次不对的问题
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

@end
