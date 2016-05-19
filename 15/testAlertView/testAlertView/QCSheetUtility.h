// ################################################################################//
//		文件名 : QCSheetUtility.h
// ################################################################################//
/*!
 @file		QCSheetUtility.h
 @brief		Sheet类型的警告框
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

typedef enum SheetType{
    kSheetNormalType,
    kSheetMultiType,
    kSheetProgressType,
    kSheetCustomControlType,
    kSheetTypeCount
}SheetTypeEnum;

@interface QCSheetUtility : NSObject
<UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

+ (id)defaultSheet;
+ (void)showNormalSheetOnView:(UIView*)aView;

- (void)showMultiOptionOnView:(UIView*)aView;
- (void)showProgressOnView:(UIView*)aView;
- (void)showCustomControlType:(UIView*)aView;
@end
