// ################################################################################//
//		文件名 : QCDrawGraphView.h
// ################################################################################//
/*!
 @file		QCDrawGraphView.h
 @brief		画固定图形的画板视图
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

typedef enum {
    kLineGraph = 0,
    kRectGraph,
    kRoundGraph
} GraphType;

@interface QCDrawGraphView : UIView

//提供给外部配置的参数
@property (nonatomic, retain) UIColor   *color;
@property (nonatomic, assign) GraphType type;


@end
