// ################################################################################//
//		文件名 : QCDrawGraphViewController.m
// ################################################################################//
/*!
 @file		QCDrawGraphViewController.m
 @brief		画固定图形的视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/01     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDrawGraphViewController.h"

@interface QCDrawGraphViewController ()

@property (nonatomic, retain) IBOutlet UISegmentedControl   *typeSegControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl   *colorSegControl;

@end

@implementation QCDrawGraphViewController
@synthesize typeSegControl;
@synthesize colorSegControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化配置参数
    [self actSelectColor:self.colorSegControl];
    [self actGraphType:self.typeSegControl];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.typeSegControl = nil;
    self.colorSegControl = nil;
}

#pragma mark -
#pragma mark Action
- (IBAction)actSelectColor:(id)sender 
{
    UISegmentedControl *control = sender;
    NSInteger index = [control selectedSegmentIndex];
    
    QCDrawGraphView *myView = (QCDrawGraphView *)self.view;
    
    switch (index) {
        case 0:
            myView.color = [UIColor redColor];
            break;
        case 1:
            myView.color = [UIColor blueColor];
            break;
        default:
            break;
    }
}

- (IBAction)actGraphType:(id)sender 
{
    UISegmentedControl *control = sender;
    NSInteger index = [control selectedSegmentIndex];
    
    QCDrawGraphView *myView = (QCDrawGraphView *)self.view;
    
    switch (index) {
        case 0:
            myView.type     = kLineGraph;
            break;
        case 1:
            myView.type     = kRectGraph;
            break;
        case 2:
            myView.type     = kRoundGraph;
            break;
        default:
            break;
    }
}

- (IBAction)actClose:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 
                             }];
}

@end
