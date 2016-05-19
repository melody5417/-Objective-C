// ################################################################################//
//		文件名 : QCBadgeViewController.h
// ################################################################################//
/*!
 @file		QCBadgeViewController.h
 @brief		TabbarController的第一个视图控制器：“标记”
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCBadgeViewController : UIViewController
{
    //标记
    NSString    *_badge;
    
    //编辑TabbarController的视图顺序时，需要此成员量以记录开始编辑时的序号
    NSUInteger  _beginIndex;
}
//文本输入框控件
@property(nonatomic, retain) IBOutlet   UITextField *badgeTxtF;

//下列函数作用：
//针对TabbarController编辑功能的接口
//用于动态地将“标记”更新到正确的Tabbar位置上
- (void)beginCustomizing:(NSUInteger)beginIndex
      onTabBarController:(UITabBarController*)aTabbarController;
- (void)endCustomizing:(NSUInteger)newIndex
    onTabBarController:(UITabBarController*)aTabbarController;
- (IBAction)actAddBadge:(id)sender;

@end
