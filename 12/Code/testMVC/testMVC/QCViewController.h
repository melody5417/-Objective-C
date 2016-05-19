// ################################################################################//
//		文件名 : QCViewController.h
// ################################################################################//
/*!
 @file		QCViewController.h
 @brief		显示视图类头文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>
#import "QCPersonInfoDataModel.h"

@interface QCViewController : UIViewController

@property(nonatomic, retain) IBOutlet   UILabel *labName;
@property(nonatomic, retain) IBOutlet   UILabel *labAge;
@property(nonatomic, retain) IBOutlet   UILabel *labMarried;
@property(nonatomic, retain) IBOutlet   UILabel *labHeight;
@property(nonatomic, retain) IBOutlet   UILabel *labHobby;

- (void)updateViewContent:(QCPersonInfoDataModel*)aNewPersonInfo;

@end
