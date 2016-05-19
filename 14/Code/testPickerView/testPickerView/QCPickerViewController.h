// ################################################################################//
//		文件名 : RMPlayerDM.h
// ################################################################################//
/*!
 @file		RMPlayerDM.h
 @brief		Real Madrid球队球员的Data Model
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

@interface RMPlayerDM : NSObject

//球员名
@property(nonatomic, retain) NSString  *name;
//球员号码
@property(nonatomic, retain) NSNumber  *number;
//球员角色
@property(nonatomic, retain) NSString  *role;

@end

// ################################################################################//
//		文件名 : QCPickerViewController.h
// ################################################################################//
/*!
 @file		QCPickerViewController.h
 @brief		通用式样取值控件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
@interface QCPickerViewController : UIViewController{
    //取值控件的数据源
    //@property中的数据源是只读形式，为了方便起见，我们自己做一个成员量
    NSArray         *_datasource;
    
    //当前选中的“角色”序号
    NSUInteger      _currentRoleIndex;
}

@property(nonatomic, readonly, retain) NSArray  *datasource;
//界面上的2个控件
@property(nonatomic, readonly, retain) IBOutlet UILabel         *info;
@property(nonatomic, readonly, retain) IBOutlet UIPickerView    *picker;


- (void)initData;
- (void)initPlistData;
- (void)showInfo:(UIPickerView *)pickerView
      onRowIndex:(NSInteger)row
     inComponent:(NSInteger)component;

@end
