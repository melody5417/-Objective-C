// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@implementation QCViewController
@synthesize labTitleText = _labTitleText;
@synthesize labContent = _labContent;
@synthesize imgContent = _imgContent;
@synthesize labCurrentLocal = _labCurrentLocal;
@synthesize labTime = _labTime;

- (void)dealloc
{
    SAFE_RELEASE(_labTitleText)
    SAFE_RELEASE(_labContent)
    SAFE_RELEASE(_imgContent)
    SAFE_RELEASE(_labCurrentLocal)
    SAFE_RELEASE(_labTime)

    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    //位于xib上的三个控件内容赋值
    self.labTitleText.text  = NSLocalizedString(@"TITLE_TEXT", @"");
    self.labContent.text    = NSLocalizedString(@"CONTENT_TEXT", @"");
    self.imgContent.image   = [UIImage imageNamed:@"iOSDevice"];
    
    //中文Locale
    NSLocale    *chsLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"] autorelease];
    
    //将[[NSLocale currentLocale] localeIdentifier]的内容以中文显示到控件上
    self.labCurrentLocal.text = [NSString stringWithFormat:@"[%@]",
                            [chsLocale displayNameForKey:NSLocaleIdentifier
                                                   value:[[NSLocale currentLocale] localeIdentifier]]];
    
    //将当前系统时区的时间显示到控件上
    //需要用到NSDateFormatter来配置日期显示的具体参数
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    self.labTime.text = [dateFormatter stringFromDate:[NSDate date]];
}

#pragma mark -
#pragma mark iOS6.0 prior
- (void)viewDidUnload
{
    [super viewDidUnload];

    self.labTitleText       = nil;
    self.labContent         = nil;
    self.imgContent         = nil;
    self.labCurrentLocal    = nil;
    self.labTime            = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
