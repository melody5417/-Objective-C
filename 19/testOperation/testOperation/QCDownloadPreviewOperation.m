// ################################################################################//
//		文件名 : QCDownloadPreviewOperation.m
// ################################################################################//
/*!
 @file		QCDownloadPreviewOperation.m
 @brief		大图下载类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDownloadPreviewOperation.h"

@implementation QCDownloadPreviewOperation
@synthesize delegate = _delegate;

- (void)downloadImgFinished:(UIImage*)aImage {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (aImage && _delegate) {
            [_delegate downloadPreviewEnd:self
                                  withImg:aImage];
        }
    });
}

@end
