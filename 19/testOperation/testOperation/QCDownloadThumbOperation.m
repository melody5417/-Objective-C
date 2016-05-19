// ################################################################################//
//		文件名 : QCDownloadThumbOperation.m
// ################################################################################//
/*!
 @file		QCDownloadThumbOperation.m
 @brief		小图下载类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDownloadThumbOperation.h"

#define kThumbImgSize 48.0f
@interface QCDownloadThumbOperation() {
    //小图链接
    NSURL           *_urlThumbImage;
    
    //回调block
    FinishBlock     _finishBlock;
    
    //图片大小
    //外部配置，返回图像时根据具体值进行缩放
    CGSize          _imageSize;
    
    //控制并发任务的变量
    BOOL            _executing;
    BOOL            _finished;
}

@property (nonatomic, copy)     FinishBlock     finishBlock;
@property (nonatomic, retain)   NSURL           *urlThumbImage;

@end

@implementation QCDownloadThumbOperation
@synthesize finishBlock = _finishBlock;
@synthesize urlThumbImage = _urlThumbImage;

- (id)init {
    self = [super init];
    if (self) {
        _imageSize.height   = kThumbImgSize;
        _imageSize.width    = kThumbImgSize;
        _executing          = NO;
        _finished           = NO;
    }
    return self;
}

- (id)initWithURL:(NSURL *)url
  finishedHandler:(FinishBlock)finishBlock
{
    self = [self init];
    if (self != nil)
    {
        self.urlThumbImage          = url;
        self.finishBlock            = finishBlock;
    }
    return self;
}

- (void)dealloc
{
    SAFE_RELEASE(_finishBlock);
    SAFE_RELEASE(_urlThumbImage);
    
    [super dealloc];
}

- (void)setOutputImageSize:(CGSize)imageSize
{
    _imageSize.height   = imageSize.height;
    _imageSize.width    = imageSize.width;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

//Operation执行入口
- (void)start
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(start)
                               withObject:nil
                            waitUntilDone:NO];
        return;
    }
    
    if( [self isFinished] || [self isCancelled] ) {
        [self endOperation];
        return;
    }
    
    [self willChangeValueForKey: @"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey: @"isExecuting"];
    
    [self performSelectorInBackground:@selector(main)
                           withObject:nil];
}

- (void)endOperation
{
    [self willChangeValueForKey: @"isExecuting"];
    _executing = NO;
    [self didChangeValueForKey: @"isExecuting"];
    
    [self willChangeValueForKey: @"isFinished"];
    _finished = YES;
    [self didChangeValueForKey: @"isFinished"];
}

//供start函数调用
- (void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
    if( [self isFinished] || [self isCancelled] ) {
        [self endOperation];
        [pool release];
        return;
    }
    
    UIImage     *image  = nil;
    UIImage     *outImg = nil;
	if (self.urlThumbImage) {
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlThumbImage]];
        
        if( [self isFinished] || [self isCancelled] ) {
            [self endOperation];
            [pool release];
            return;
        }
        
        if (image) {
            UIGraphicsBeginImageContext(_imageSize);
            [image drawInRect:CGRectMake(0.0f,
                                         0.0f,
                                         _imageSize.width,
                                         _imageSize.height)];
            outImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    
    [self downloadImgFinished:outImg];

    
    [self endOperation];
    [pool release];
}

- (void)downloadImgFinished:(UIImage*)aImage {
    if (aImage && _finishBlock) {
        self.finishBlock(aImage);
    }
}

@end
