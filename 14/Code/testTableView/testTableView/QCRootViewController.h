// ################################################################################//
//		文件名 : QCRootViewController.h
// ################################################################################//
/*!
 @file		QCRootViewController.h
 @brief		程序根视图的导航控制器的根视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface QCRootViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic, retain) IBOutlet   UIScrollView    *scrollView;
@property(nonatomic, retain) IBOutlet   UIView          *plainListView;
@property(nonatomic, retain) IBOutlet   UIView          *editListView;
@property(nonatomic, retain) IBOutlet   UIView          *groupListView;
@property(nonatomic, retain) UIPageControl              *pageControl;

//plain
- (IBAction)actSimpleTableView:(id)sender;
- (IBAction)actSectionTableView:(id)sender;
- (IBAction)actIndexTableView:(id)sender;
- (IBAction)actInfoTableView:(id)sender;
- (IBAction)actValue1TableView:(id)sender;
- (IBAction)actValue2TableView:(id)sender;
- (IBAction)actCustomLayoutTableView:(id)sender;

//edit
- (IBAction)actDeleteTableView:(id)sender;
- (IBAction)actInsertTableView:(id)sender;
- (IBAction)actMoveTableView:(id)sender;
- (IBAction)actMultiSelectionTableView:(id)sender;

//group
- (IBAction)actGSimpleTableView:(id)sender;
- (IBAction)actGSectionTableView:(id)sender;
- (IBAction)actGIndexTableView:(id)sender;
- (IBAction)actGInfoTableView:(id)sender;
- (IBAction)actGValue1TableView:(id)sender;
- (IBAction)actGValue2TableView:(id)sender;
- (IBAction)actGCusomLayoutTableView:(id)sender;

@end
