// ################################################################################//
//		文件名 : QCCustomRowView.m
// ################################################################################//
/*!
 @file		QCCustomRowView.m
 @brief		自定义取值控件的行内容
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomRowView.h"

@implementation QCCustomRowView
@synthesize photo = _photo;
@synthesize name = _name;

//重写重画函数
//自定义内容均在此
- (void)drawRect:(CGRect)rect
{
    //照片
    if (!_photoView) {
        _photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f,
                                                                   0.0f,
                                                                   CGRectGetHeight(self.frame),
                                                                   CGRectGetHeight(self.frame))];
        _photoView.backgroundColor = [UIColor clearColor];
        [self addSubview:_photoView];
    }
    _photoView.image = self.photo;
    
    //球员名字
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_photoView.frame),
                                                               0.0f,
                                                               CGRectGetWidth(self.frame) - CGRectGetMaxX(_photoView.frame) - 5.0f,
                                                               CGRectGetHeight(self.frame))];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.textColor     = [UIColor darkGrayColor];
        _nameLabel.shadowColor   = [UIColor blackColor];
        _nameLabel.shadowOffset  = CGSizeMake(1.0f, 1.0f);
        _nameLabel.numberOfLines = 0;
        _nameLabel.font          = [UIFont systemFontOfSize:14.0f];
        
        [self addSubview:_nameLabel];
    }
    
    _nameLabel.text = self.name;
}

- (void)dealloc
{
    [_photoView release];
    [_nameLabel release];
    [super dealloc];
}

@end
