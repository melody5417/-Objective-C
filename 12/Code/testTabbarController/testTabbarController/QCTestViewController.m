// ################################################################################//
//		文件名 : QCTestViewController.m
// ################################################################################//
/*!
 @file		QCTestViewController.m
 @brief		TabbarController的第四个开始的之后所有视图控制器：“随机内容颜色视图”
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/19     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCTestViewController.h"

@implementation QCTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                title:(NSString*)title
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"test"];
        
        //由外部传入标题
        if (title) {
            self.title = title;
        }
    }
    return self;
}

//重写UIViewController的默认创建接口
//避免使用此接口而没有设置标题的意外
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithNibName:nibNameOrNil
                          bundle:nibBundleOrNil
                           title:@"请给我个标题"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //随机的背景色
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)(arc4random()%255)/(CGFloat)255.0f
                                                green:(CGFloat)(arc4random()%255)/(CGFloat)255.0f
                                                 blue:(CGFloat)(arc4random()%255)/(CGFloat)255.0f
                                                alpha:1.0f];
}

@end
