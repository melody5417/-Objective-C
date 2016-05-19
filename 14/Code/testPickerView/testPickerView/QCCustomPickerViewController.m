// ################################################################################//
//		文件名 : QCCustomPickerViewController.m
// ################################################################################//
/*!
 @file		QCCustomPickerViewController.m
 @brief		日期式样的取值控件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomPickerViewController.h"
#import "QCCustomRowView.h"

@implementation QCCustomPickerViewController

//重写父类的initData
//简化数据内容
- (void)initData {
    [self initPlistData];
}

#pragma mark -
#pragma mark Utility
//重写父类的showInfo
- (void)showInfo:(UIPickerView *)pickerView
      onRowIndex:(NSInteger)row
     inComponent:(NSInteger)component
{
    RMPlayerDM  *onePlayer      = nil;

    if (row < _datasource.count) {
        onePlayer = [_datasource objectAtIndex:row];
    }
    if (onePlayer) {
        self.info.text = [NSString stringWithFormat:@"我是%@：%@",
                          onePlayer.role,
                          onePlayer.name];
    }
    else{
        self.info.text = @"取值异常";
    }
}

#pragma mark -
#pragma mark UIPicker datasource
//几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //只显示球员
    return 1;
}

//每列几行选项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _datasource.count;

}

//每列的宽
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return CUSTOM_WIDTH;
}

//每列的高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return CUSTOM_HEIGHT;
}

#pragma mark -
#pragma mark UIPicker delegate
//自定义UIPickerView的选项视图
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    QCCustomRowView   *aCustomView    = nil;
    RMPlayerDM          *onePlayer      = nil;
    
    //异常
    if (row >= _datasource.count) {
        return [[[UIView alloc] init] autorelease];
    }
    
    //取出相应的球员对象
    onePlayer = [_datasource objectAtIndex:row];
	if (view) {
        //重用
        aCustomView = (QCCustomRowView*)view;
        
        //让重用的视图再次调用drawRect方法
        [aCustomView setNeedsDisplay];
    }
    else{
        //新建
        aCustomView = [[[QCCustomRowView alloc] initWithFrame:CGRectMake(0.0f,
                                                                         0.0f,
                                                                         CUSTOM_WIDTH,
                                                                         CUSTOM_HEIGHT)] autorelease];
        aCustomView.backgroundColor = [UIColor clearColor];
    }
    
    //配置自定义视图
    aCustomView.photo = [UIImage imageNamed:[NSString stringWithFormat:@"%@", onePlayer.number]];
    aCustomView.name  = onePlayer.name;
    
    return aCustomView;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    [self showInfo:pickerView onRowIndex:row inComponent:component];
}

@end
