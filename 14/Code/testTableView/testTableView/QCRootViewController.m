// ################################################################################//
//		文件名 : QCRootViewController.m
// ################################################################################//
/*!
 @file		QCRootViewController.m
 @brief		程序根视图的导航控制器的根视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/05     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCRootViewController.h"
#import "QCSimpleTableViewController.h"
#import "QCSectionTableViewController.h"
#import "QCIndexedTableViewController.h"
#import "QCInfoViewController.h"
#import "QCValue1TableViewController.h"
#import "QCValue2TableViewController.h"
#import "QCCustomLayoutViewController.h"
#import "QCDeleteViewController.h"
#import "QCInsertViewController.h"
#import "QCMoveViewController.h"
#import "QCMultiSelectionViewController.h"
#import "QCGIndexedTableViewController.h"

@implementation QCRootViewController
@synthesize pageControl;

- (void)dealloc
{
    [_plainListView release];
    [_editListView release];
    [_groupListView release];
    [_scrollView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏的颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:145.0f/255.0f
                                                                        green:190.0f/255.0f
                                                                         blue:5.0f/255.0f
                                                                        alpha:1.0f];
    //导航栏的标题
    self.title = @"表视图示例";
    
    //初始化UI
    [self initUI];
}

- (void)initUI
{
//scrollview配置
    //1)Plain
    _plainListView.frame = _scrollView.bounds;
    [_scrollView addSubview:_plainListView];
    
    //2)Group
    _groupListView.frame = CGRectMake(CGRectGetWidth(_scrollView.frame),
                                      0.0f,
                                      CGRectGetWidth(_groupListView.frame),
                                      CGRectGetHeight(_groupListView.frame));
    [_scrollView addSubview:_groupListView];
    
    //3)Edit
    _editListView.frame = CGRectMake(2*CGRectGetWidth(_scrollView.frame),
                                     0.0f,
                                     CGRectGetWidth(_editListView.frame),
                                     CGRectGetHeight(_editListView.frame));
    [_scrollView addSubview:_editListView];
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_plainListView.frame) + CGRectGetWidth(_groupListView.frame) + CGRectGetWidth(_editListView.frame),
                                           CGRectGetHeight(_scrollView.frame))];
    [_scrollView flashScrollIndicators];
    
//导航栏右侧pageControl配置
    UIPageControl   *aPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                                    0.0f,
                                                                                    38.0f,
                                                                                    36.0f)];
    aPageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    aPageControl.hidesForSinglePage = YES;
    aPageControl.numberOfPages = 3;
    [aPageControl addTarget:self action:@selector(actScrollPage:) forControlEvents:UIControlEventTouchUpInside];
    self.pageControl = aPageControl;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aPageControl];
    [aPageControl release];
}

#pragma mark -iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait) ||
    (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark -iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark -
#pragma mark Action
#pragma mark -PageControl
- (IBAction)actScrollPage:(id)sender
{
    int nPageIndex = ((UIPageControl*)sender).currentPage;
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.frame) * nPageIndex,
                                              0.0f)
                         animated:YES];
}

#pragma mark -Plain
- (IBAction)actSimpleTableView:(id)sender
{
    QCSimpleTableViewController *simpleTVC = [[QCSimpleTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:simpleTVC
                                         animated:YES];
    [simpleTVC release];
}

- (IBAction)actSectionTableView:(id)sender
{
    QCSectionTableViewController *sectionTVC = [[QCSectionTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:sectionTVC
                                         animated:YES];
    [sectionTVC release];
}

- (IBAction)actIndexTableView:(id)sender
{
    QCIndexedTableViewController *indexTVC = [[QCIndexedTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:indexTVC
                                         animated:YES];
    [indexTVC release];
}

- (IBAction)actInfoTableView:(id)sender
{
    QCInfoViewController *infoTVC = [[QCInfoViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:infoTVC
                                         animated:YES];
    [infoTVC release];
}

- (IBAction)actValue1TableView:(id)sender
{
    QCValue1TableViewController *value1VC = [[QCValue1TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:value1VC
                                         animated:YES];
    [value1VC release];
}

- (IBAction)actValue2TableView:(id)sender
{
    QCValue2TableViewController *value2VC = [[QCValue2TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:value2VC
                                         animated:YES];
    [value2VC release];
}

- (IBAction)actCustomLayoutTableView:(id)sender
{
    QCCustomLayoutViewController *customVC = [[QCCustomLayoutViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:customVC
                                         animated:YES];
    [customVC release];
}

#pragma mark -Edit
- (IBAction)actDeleteTableView:(id)sender
{
    QCDeleteViewController *deleteVC = [[QCDeleteViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:deleteVC
                                         animated:YES];
    [deleteVC release];
}

- (IBAction)actInsertTableView:(id)sender
{
    QCInsertViewController *insertVC = [[QCInsertViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:insertVC
                                         animated:YES];
    [insertVC release];
}

- (IBAction)actMoveTableView:(id)sender
{
    QCMoveViewController *moveVC = [[QCMoveViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:moveVC
                                         animated:YES];
    [moveVC release];
}

- (IBAction)actMultiSelectionTableView:(id)sender
{
    QCMultiSelectionViewController *multiSelectVC = [[QCMultiSelectionViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController pushViewController:multiSelectVC
                                         animated:YES];
    [multiSelectVC release];
}

#pragma mark -Grouped
- (IBAction)actGSimpleTableView:(id)sender
{
    QCSimpleTableViewController *simpleTVC = [[QCSimpleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:simpleTVC
                                         animated:YES];
    [simpleTVC release];
}

- (IBAction)actGSectionTableView:(id)sender
{
    QCSectionTableViewController *sectionTVC = [[QCSectionTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:sectionTVC
                                         animated:YES];
    [sectionTVC release];
}

- (IBAction)actGIndexTableView:(id)sender
{
    QCGIndexedTableViewController *indexTVC = [[QCGIndexedTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:indexTVC
                                         animated:YES];
    [indexTVC release];
}

- (IBAction)actGInfoTableView:(id)sender
{
    QCInfoViewController *infoTVC = [[QCInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:infoTVC
                                         animated:YES];
    [infoTVC release];
}

- (IBAction)actGValue1TableView:(id)sender
{
    QCValue1TableViewController *value1VC = [[QCValue1TableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:value1VC
                                         animated:YES];
    [value1VC release];
}

- (IBAction)actGValue2TableView:(id)sender
{
    QCValue2TableViewController *value2VC = [[QCValue2TableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:value2VC
                                         animated:YES];
    [value2VC release];
}

- (IBAction)actGCusomLayoutTableView:(id)sender
{
    QCCustomLayoutViewController *customVC = [[QCCustomLayoutViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    [self.navigationController pushViewController:customVC
                                         animated:YES];
    [customVC release];
}

#pragma mark -
#pragma mark UIScrollView delegate
//将ScrollView和PageControl同步
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int pageIndex = _scrollView.contentOffset.x / CGRectGetWidth(_scrollView.frame);
    
    if (pageIndex > self.pageControl.numberOfPages - 1) {
        pageIndex = self.pageControl.numberOfPages - 1;
    }

    self.pageControl.currentPage = pageIndex;
}

@end
