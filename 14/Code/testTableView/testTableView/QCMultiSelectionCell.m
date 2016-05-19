// ################################################################################//
//		文件名 :QCMultiSelectionCell.m
// ################################################################################//
/*!
 @file		QCMultiSelectionCell.m
 @brief		多选功能表视图控制器的自定义行
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/06     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCMultiSelectionCell.h"

@implementation QCMultiSelectionCell
@synthesize checked = _isSelected;

//两种情况会调用
//(1)Cell首次显示
//(2)tableview执行了setEditing:animated:
- (void) setEditing:(BOOL)editting animated:(BOOL)animated
{
    //和当前状态相同
	if (self.editing == editting) {
		return;
	}
	
    //不要破坏原本的系统动作
	[super setEditing:editting animated:animated];
	
    //进入编辑状态
	if (editting)
	{
        //背景视图生成，以准备设置选中和未选中的不同背景色
		self.backgroundView = [[[UIView alloc] init] autorelease];
		self.backgroundView.backgroundColor = [UIColor whiteColor];
		
        //表示选中与否的图片，位置和编辑状态的控件相同，同样放在最左边
        //不过考虑到进入编辑状态，cell是一个从左向右的动画移动，所以初始化这个图片也放在负X位置，准备从左向右做一个动画来显示
		if (!_imgSelectionMark)
		{
            _imgSelectionMark = [[UIImageView alloc] initWithFrame:CGRectMake(-14.5f,
                                                                              CGRectGetHeight(self.bounds)/2 - 14.5f,
                                                                              29.0f,
                                                                              29.0f)];
            _imgSelectionMark.alpha = 0.0f;
			[self addSubview:_imgSelectionMark];
		}
		
        //更新选中与否的界面显示
		[self setChecked:_isSelected];
        
        //从左向右的移动且显示动画
        [UIView animateWithDuration:0.3f animations:^{
            _imgSelectionMark.frame = CGRectMake(6.0f,
                                                 CGRectGetMinY(_imgSelectionMark.frame),
                                                 CGRectGetWidth(_imgSelectionMark.frame),
                                                 CGRectGetHeight(_imgSelectionMark.frame));
            _imgSelectionMark.alpha = 1.0f;
        }];
	}
	else
	{
        //背景视图销毁，大家都变成普通的颜色，即默认白色
		self.backgroundView = nil;
        
        //文字颜色变回来
        self.textLabel.textColor            = [UIColor blackColor];
        self.detailTextLabel.textColor      = [UIColor grayColor];
        
        //从右向左的移动且隐藏动画
        [UIView animateWithDuration:0.3f animations:^{
            _imgSelectionMark.frame = CGRectMake(-14.5f,
                                                 CGRectGetMinY(_imgSelectionMark.frame),
                                                 CGRectGetWidth(_imgSelectionMark.frame),
                                                 CGRectGetHeight(_imgSelectionMark.frame));
            _imgSelectionMark.alpha = 0.0f;
        }];
	}
}


- (void)dealloc
{
    if (_imgSelectionMark) {
        [_imgSelectionMark release];
    }
    [super dealloc];
}


- (void) setChecked:(BOOL)checked
{
    //选中
	if (checked)
	{
        //勾选的图标
		_imgSelectionMark.image             = [UIImage imageNamed:@"CheckBoxYes"];
        //勾选状态的背景颜色
		self.backgroundView.backgroundColor = [UIColor colorWithRed:38.0/255.0
                                                              green:96.0/255.0
                                                               blue:211.0/255.0
                                                              alpha:1.0];
        self.textLabel.textColor            = [UIColor whiteColor];
        self.detailTextLabel.textColor      = [UIColor whiteColor];
	}
    //反选
	else
	{
        //反选的图标
		_imgSelectionMark.image             = [UIImage imageNamed:@"CheckBoxNo"];
		self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        self.textLabel.textColor            = [UIColor blackColor];
        self.detailTextLabel.textColor      = [UIColor grayColor];
	}
	
    //需要记录到成员量中
    _isSelected = checked;
}

@end
