// ################################################################################//
//		文件名 : QCCustomActivity.h
// ################################################################################//
/*!
 @file		QCCustomActivity.h
 @brief		自定义Activity按钮
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/11     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@protocol CustomActivityDelegate;
@interface QCCustomActivity : UIActivity
@property(nonatomic, assign) id<CustomActivityDelegate> delegate;
@end

@protocol CustomActivityDelegate <NSObject>
- (void)finishTask:(QCCustomActivity*)anActivity;
@end
