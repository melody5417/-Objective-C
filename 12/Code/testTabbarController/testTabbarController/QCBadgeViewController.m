// ################################################################################//
//		文件名 : QCBadgeViewController.m
// ################################################################################//
/*!
 @file		QCBadgeViewController.m
 @brief		TabbarController的第一个视图控制器：“标记”
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCBadgeViewController.h"

@interface QCBadgeViewController()
@property(nonatomic, retain)  NSString *badgeContent;
@end

@implementation QCBadgeViewController
@synthesize badgeContent = _badge;

- (void)dealloc {
    [_badgeTxtF release];
    [_badge release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Tabbar图标
        self.tabBarItem.image = [UIImage imageNamed:@"test"];
        
        //Tabbar标题
        self.title = @"标记";
    }
    return self;
}

#pragma mark -
#pragma mark Action
//“添加标记”按钮
- (IBAction)actAddBadge:(id)sender
{
    //收起键盘
    [self.view endEditing:YES];
    
    //文本输入控件中有内容
    if (_badgeTxtF.text.length > 0) {
        //位于导航视图控制器时，例如"More"标签中
        //则需要更新导航视图控制器的“标记”
        if (self.navigationController) {
            self.navigationController.tabBarItem.badgeValue = _badgeTxtF.text;
        }
        //一般时候
        //只需要更新Tabbar的标记即可
        else{
            self.tabBarItem.badgeValue = _badgeTxtF.text;
        }
        
        //成员量保存
        self.badgeContent = _badgeTxtF.text;
    }
}

- (void)beginCustomizing:(NSUInteger)beginIndex
      onTabBarController:(UITabBarController*)aTabbarController
{
    //开始自定义Tabbar顺序时，自己的具体位置先记下来
    _beginIndex = beginIndex;
    
//将当前的“标记”读取出来
    //有“More”的TabbarController
    if (aTabbarController.viewControllers.count > 5) {
        //在“More”中，即自己在一个导航控制器中
        if (beginIndex > 4) {
            self.badgeContent = aTabbarController.moreNavigationController.tabBarItem.badgeValue;
        }
        //在Tabbar底下直接可以看到
        else {
            self.badgeContent = _badgeTxtF.text;
        }
    }
    //在Tabbar底下直接可以看到
    else{
        self.badgeContent = _badgeTxtF.text;
    }
    
    //开始自定义Tabbar顺序时，先清空“标记”
    if (self.tabBarItem) {
        self.tabBarItem.badgeValue = nil;
    }
}

- (void)endCustomizing:(NSUInteger)newIndex
    onTabBarController:(UITabBarController*)aTabbarController
{
//如果当前TabbarController没有“More”
    //直接将“标记”设到界面
    if (aTabbarController.viewControllers.count <= 5) {
        self.tabBarItem.badgeValue = self.badgeContent;
        return;
    }
    
//有“More”
    //最后自己座落在前4个位置，即不在“More”中
    if (newIndex <= 4) {
        //编辑一开始时，自己是在“More”中的话
        //需要将原本导航控制器上的“标记”设到现在界面上
        //并且将导航控制器上的“标记”清掉
        if (_beginIndex > 4) {
            self.tabBarItem.badgeValue = aTabbarController.moreNavigationController.tabBarItem.badgeValue;
            aTabbarController.moreNavigationController.tabBarItem.badgeValue = nil;
        }
        //直接将“标记”设到界面
        else{
            if (self.badgeContent && self.badgeContent.length > 0) {
                self.tabBarItem.badgeValue = self.badgeContent;
            }
        }
    }
    //最后自己座落在“More”中
    else {
        //编辑一开始时，自己是不在“More”中的话，说明导航控制器的“标记”没有设置过
        //需要立即将当前的“标记”设置上去
        if (_beginIndex <= 4) {
            aTabbarController.moreNavigationController.tabBarItem.badgeValue = self.badgeContent;
        }
    }
    
}

@end
