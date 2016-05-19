// ################################################################################//
//		文件名 : QCPreviewViewController.m
// ################################################################################//
/*!
 @file		QCPreviewViewController.m
 @brief		大图视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCPreviewViewController.h"
#import "QCDownloadPreviewOperation.h"

@interface QCPreviewViewController () <DownloadPreviewDelegate> {
    QCDownloadPreviewOperation    *_aOperation;
}

@property (nonatomic, retain) NSOperationQueue  *queue;
@end

@implementation QCPreviewViewController
@synthesize previewImage    = _previewImage;
@synthesize indicator       = _indicator;
@synthesize maskView        = _maskView;
@synthesize queue           = _queue;
@synthesize url             = _url;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"游戏预览";
    
    if (!_url) {
        return;
    }
    
    [self.view addSubview:self.maskView];
    [self.indicator startAnimating];
    
    UITapGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchViewMode)];
    [self.view addGestureRecognizer:recognizer];
    SAFE_RELEASE(recognizer);
    
    _aOperation = [[QCDownloadPreviewOperation alloc] initWithURL:_url
                                                  finishedHandler:NULL];
    _aOperation.delegate = self;
    [_aOperation setOutputImageSize:CGSizeMake(320.0f,
                                               320.0f)];
    [_aOperation start];
}

- (void)dealloc
{
    _aOperation.delegate = nil;
    [_aOperation cancel];
    
    SAFE_RELEASE(_aOperation);
    SAFE_RELEASE(_previewImage);
    SAFE_RELEASE(_indicator);
    SAFE_RELEASE(_maskView);
    
    [super dealloc];
}

- (void)switchViewMode
{
    if ([UIApplication sharedApplication].statusBarHidden) {    
        [[UIApplication sharedApplication] setStatusBarHidden:NO
                                                withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:NO
                                                 animated:YES];
    }
    else{
        [[UIApplication sharedApplication] setStatusBarHidden:YES
                                                withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:YES
                                                 animated:YES];
    }

}

- (void)downloadPreviewEnd:(QCDownloadPreviewOperation*)aOperation
                   withImg:(UIImage*)aImage
{
    _previewImage.image = aImage;
   [UIView animateWithDuration:10.0f
                    animations:^{
                        self.maskView.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        if (_indicator) {
                            [_indicator stopAnimating];
                        }
                    }];
}

@end
