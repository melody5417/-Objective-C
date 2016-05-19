// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/23     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import "QCGameAppRecord.h"
#import "QCDownloadThumbOperation.h"
#import "QCPreviewViewController.h"

@interface QCViewController () {
    NSOperationQueue    *_queue;
}

@property (nonatomic, retain) IBOutlet UIView                   *maskView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *indicator;
@property (nonatomic, retain) IBOutlet UITableView              *tableview;

@end

@implementation QCViewController
@synthesize dataSource = _dataSource;
@synthesize maskView;
@synthesize indicator;
@synthesize tableview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //导航栏的颜色设置
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:145.0f/255.0f
                                                                        green:190.0f/255.0f
                                                                         blue:5.0f/255.0f
                                                                        alpha:1.0f];
    self.navigationItem.title  = @"畅销游戏前50名";
    
    [self.view addSubview:self.maskView];
    [self.indicator startAnimating];
}

- (void)dealloc
{
    SAFE_RELEASE(_dataSource);
    [super dealloc];
}

- (void)reloadData {
    if (_dataSource.count > 0) {
        [UIView animateWithDuration:0.5f
                         animations:^{
                             self.maskView.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self.indicator stopAnimating];
                             [self.tableview reloadData];
                         }];
    }
}

#pragma mark -
#pragma mark Table view creation (UITableViewDataSource)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL               *urlPreview     = nil;
    QCGameAppRecord     *aRecord        = [self.dataSource objectAtIndex:indexPath.row];
    
    if (aRecord.largeImageURLString) {
        urlPreview = [NSURL URLWithString:aRecord.largeImageURLString];
    }
    QCPreviewViewController   *previewController = [[QCPreviewViewController alloc] initWithNibName:@"QCPreviewViewController"
                                                                                             bundle:nil];
    previewController.url = urlPreview;
    if(previewController) {
        [self.navigationController pushViewController:previewController
                                             animated:YES];
        SAFE_RELEASE(previewController);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"tableCellReuseID";
    
    int recodeCnt = 0;
    if (_dataSource) {
        recodeCnt = _dataSource.count;
    }
    
    if (recodeCnt > 0) {
        [self.indicator stopAnimating];
        [self.maskView removeFromSuperview];
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType  = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    if (recodeCnt > 0)
	{
        QCGameAppRecord *gameRecord = [self.dataSource objectAtIndex:indexPath.row];
        
		cell.textLabel.text = gameRecord.name;
        cell.detailTextLabel.text = gameRecord.price;
		
        if (!gameRecord.imgThumb)
        {
            if (self.tableview.dragging == NO && self.tableview.decelerating == NO) {
                [self downloadThumbImageForGame:gameRecord inTableViewLoc:indexPath];
            }
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        }
        else
        {
            cell.imageView.image = gameRecord.imgThumb;
        }
        
    }
    
    return cell;
}

- (void)downloadThumbImageForGame:(QCGameAppRecord*)aRecord
                   inTableViewLoc:(NSIndexPath*)indexPath
{
    if (!aRecord || !indexPath) {
        return;
    }
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:5];
    }
    
    NSURL   *urlThumb   = nil;
    __block QCGameAppRecord *gameRecord  = aRecord;
    if (aRecord.thumbImageURLString) {
        urlThumb = [NSURL URLWithString:aRecord.thumbImageURLString];
    }
    QCDownloadThumbOperation *aOperation = [[QCDownloadThumbOperation alloc] initWithURL:urlThumb
                                                                         finishedHandler:^(UIImage *aImage) {
                                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                                 gameRecord.imgThumb = aImage;
                                                                                 [self updateTableViewImage:aImage indexPath:indexPath];
                                                                             });
                                                                         }];
    [_queue addOperation:aOperation];
    SAFE_RELEASE(aOperation);
}

- (void)updateTableViewImage:(UIImage*)aImage
                   indexPath:(NSIndexPath*)indexPath
{
    if (!aImage || !indexPath) {
        return;
    }
    
    NSArray             *arrVisibleCell = [self.tableview visibleCells];
    UITableViewCell     *aCell          = [self.tableview cellForRowAtIndexPath:indexPath];
    if ([arrVisibleCell containsObject:aCell]) {
        aCell.imageView.image = aImage;
    }
}

- (void)loadImageOnVisibleCells
{
    NSArray *arrIndexPath = [self.tableview indexPathsForVisibleRows];
    for (NSIndexPath *aIndexPath in arrIndexPath) {
        
        QCGameAppRecord *aRecord = [self.dataSource objectAtIndex:aIndexPath.row];
        if (!aRecord.imgThumb) {
            [self downloadThumbImageForGame:aRecord
                             inTableViewLoc:aIndexPath];
        }
    }
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self loadImageOnVisibleCells];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImageOnVisibleCells];
}

@end
