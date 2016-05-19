// ################################################################################//
//		文件名 : QCDownloadThumbOperation.h
// ################################################################################//
/*!
 @file		QCDownloadThumbOperation.h
 @brief		小图下载类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>

typedef void (^FinishBlock)(UIImage* aImage);
@interface QCDownloadThumbOperation : NSOperation

- (void)setOutputImageSize:(CGSize)imageSize;
- (id)initWithURL:(NSURL *)url
  finishedHandler:(FinishBlock)finishBlock;

- (void)downloadImgFinished:(UIImage*)aImage;
@end
