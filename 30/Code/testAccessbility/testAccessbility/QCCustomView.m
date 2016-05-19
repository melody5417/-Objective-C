// ################################################################################//
//		文件名 : QCCustomView.m
// ################################################################################//
/*!
 @file		QCCustomView.m
 @brief		实现辅助功能的自定义视图
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCCustomView.h"

@interface QCCustomView ()<UITextFieldDelegate>

@property (nonatomic, retain) UILabel       *labTitle;
@property (nonatomic, retain) UITextField   *txtContent;

- (void)initUI;

@end

@implementation QCCustomView
@synthesize labTitle;
@synthesize txtContent;
@synthesize accessibleElements=_accessibleElements;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.txtContent.text.length <= 0) {
        return;
    }
    
    NSString    *strResult      = [NSString stringWithFormat:@"歌名是：%@", self.txtContent.text];
    UIFont      *font           = [UIFont boldSystemFontOfSize:24];
    CGFloat     actualFontSize  = 48.0f;
    CGSize      size            = [strResult sizeWithFont:font 
                                              minFontSize:10.0f 
                                           actualFontSize:&actualFontSize 
                                                 forWidth:(320.0f - 2*20.0f)
                                            lineBreakMode:UILineBreakModeTailTruncation];
    
    //显示“歌名”
    [strResult drawAtPoint:CGPointMake((self.bounds.size.width - size.width)/2, 
                                       CGRectGetMaxY(self.txtContent.frame) + 8.0f) 
                  forWidth:size.width 
                  withFont:font 
                  fontSize:actualFontSize 
             lineBreakMode:UILineBreakModeWordWrap
        baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
}


- (void)initUI
{
    if (!self.labTitle) {
        self.labTitle = [[[UILabel alloc] initWithFrame:CGRectMake(20.0f, 
                                                                  20.0f, 
                                                                  280.0f, 
                                                                   48.0f)] autorelease];
    }
    self.labTitle.text = @"请向下点选输入框，输入自己最喜欢的歌曲名称";
    self.labTitle.numberOfLines = 2;
    
    if (!self.txtContent) {
        self.txtContent = [[[UITextField alloc] initWithFrame:CGRectMake(20.0f, 
                                                                        76.0f, 
                                                                        280.0f, 
                                                                        31.0f)] autorelease];
    }
    self.txtContent.returnKeyType = UIReturnKeyDone;
    self.txtContent.borderStyle = UITextBorderStyleRoundedRect;
    self.txtContent.delegate = self;
    
    [self addSubview:self.labTitle];
    [self addSubview:self.txtContent];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    
    UIAccessibilityElement *songElement = [_accessibleElements objectAtIndex:_accessibleElements.count-1];
    songElement.accessibilityValue = (self.txtContent.text.length == 0)?
    @"未输入歌曲名":
    [NSString stringWithFormat:@"%@", self.txtContent.text];
    [self setNeedsDisplay];
    return YES;
}

//以下是辅助功能的实现
#pragma mark -
#pragma mark Accessibility
- (NSArray *)accessibleElements
{
    if (_accessibleElements != nil)
    {
        return _accessibleElements;
    }
    
    _accessibleElements = [[NSMutableArray alloc] initWithCapacity:0];
    
    //title
    UIAccessibilityElement *titleElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    titleElement.accessibilityFrame = [self convertRect:self.labTitle.frame toView:nil];
    titleElement.accessibilityLabel = @"我是标题";
    titleElement.accessibilityHint = @"请准备输入自己最喜欢的歌曲，输入框就在下方紧挨着";
    titleElement.accessibilityTraits = UIAccessibilityTraitStaticText;
    [_accessibleElements addObject:titleElement];
    
    //input
    UIAccessibilityElement *inputElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    inputElement.accessibilityFrame = [self convertRect:self.txtContent.frame toView:nil];
    inputElement.accessibilityLabel = @"我是输入框, 请双击调出键盘输入您最喜欢的歌曲名字，按完成键结束输入";
    inputElement.accessibilityTraits = UIAccessibilityTraitNone;
    [_accessibleElements addObject:inputElement];
    
    CGRect viewFrame = [self convertRect:self.accessibilityFrame fromView:nil];
    UIAccessibilityElement *songElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    CGRect songFrame = CGRectMake(20.0f, 
                                  CGRectGetMaxY(self.txtContent.frame) + 8.0f, 
                                  CGRectGetWidth(viewFrame) - 20.0f*2, 
                                  CGRectGetHeight(viewFrame) - (CGRectGetMaxY(self.txtContent.frame) + 8.0f));
    songElement.accessibilityFrame = [self convertRect:songFrame toView:nil];
    songElement.accessibilityLabel = @"当前歌曲名";
    songElement.accessibilityValue = (self.txtContent.text.length == 0)?
    @"未输入歌曲名":
    [NSString stringWithFormat:@"%@", self.txtContent.text];
    songElement.accessibilityTraits = UIAccessibilityTraitStaticText;
    [_accessibleElements addObject:songElement];
    
    return _accessibleElements;
}

- (BOOL)isAccessibilityElement
{
    return NO;
}

- (NSInteger)accessibilityElementCount
{
    return [[self accessibleElements] count];
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
    return [[self accessibleElements] objectAtIndex:index];
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
    return [[self accessibleElements] indexOfObject:element];
}


@end
