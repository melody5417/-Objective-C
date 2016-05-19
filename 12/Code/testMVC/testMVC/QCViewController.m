// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/12     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@implementation QCViewController
@synthesize labName;
@synthesize labAge;
@synthesize labMarried;
@synthesize labHeight;
@synthesize labHobby;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //初始化一个数据模型：aPerson
    QCPersonInfoDataModel *aPerson = [[[QCPersonInfoDataModel alloc] init]
                                      autorelease];
    aPerson.name = @"奥特曼";
    aPerson.age  = 18;
    aPerson.hasMarried  = NO;
    aPerson.height  = 6000;
    aPerson.hobbies = [NSArray arrayWithObjects:@"殴打小怪兽", @"和地球女孩恋爱", nil];
    
    //初始化界面内容
    [self updateViewContent:aPerson];
}   

- (void)dealloc
{
    [labName release];
    [labAge release];
    [labMarried release];
    [labHeight release];
    [labHobby release];

    [super dealloc];
}

#pragma mark -
#pragma mark iOS6.0 prior
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.labName        = nil;
    self.labAge         = nil;
    self.labMarried     = nil;
    self.labHeight      = nil;
    self.labHobby       = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate{
    return YES;
}

#pragma mark -
#pragma mark Utitlity
- (void)updateViewContent:(QCPersonInfoDataModel*)aNewPersonInfo
{
    //将数据模型的内容取出来，并往界面上设置
    labName.text    = [NSString stringWithFormat:@"姓名：[%@]", aNewPersonInfo.name];
    labAge.text     = [NSString stringWithFormat:@"年龄：[%d]岁", aNewPersonInfo.age];
    labMarried.text = [NSString stringWithFormat:@"婚否：[%@]",
                       (aNewPersonInfo.hasMarried)? @"已婚":@"未婚"];
    labHeight.text  = [NSString stringWithFormat:@"身高：[%d]厘米", aNewPersonInfo.height];
    labHobby.text   = [NSString stringWithFormat:@"兴趣：[%@]", [aNewPersonInfo.hobbies componentsJoinedByString:@", "]];
}


@end
