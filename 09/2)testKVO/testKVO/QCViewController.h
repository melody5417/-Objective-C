// ################################################################################//
//		文件名 : QCViewController.h
// ################################################################################//
/*!
 @file		QCViewController.h
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet    UITableView *_tbv;
}

//遵循KVC的编码规范
@property (nonatomic, retain) NSMutableArray    *dataSrc;
@property (nonatomic, retain) NSString          *titleMsg;

//提供KVC中对于一对多属性的接口
- (NSUInteger)countOfDataSrc;
- (void)insertObject:(id)anObject inDataSrcAtIndex:(NSUInteger)idx;
- (id)objectInDataSrcAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDataSrcAtIndex:(NSUInteger)idx;
@end
