// ################################################################################//
//		文件名 : QCDownloadPreviewOperation.h
// ################################################################################//
/*!
 @file		QCDownloadPreviewOperation.h
 @brief		大图下载类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDownloadThumbOperation.h"

@protocol DownloadPreviewDelegate;
@interface QCDownloadPreviewOperation : QCDownloadThumbOperation
@property (nonatomic, assign) id<DownloadPreviewDelegate> delegate;
@end

@protocol DownloadPreviewDelegate
- (void)downloadPreviewEnd:(QCDownloadPreviewOperation*)aOperation
                   withImg:(UIImage*)aImage;
@end
