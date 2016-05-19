// ################################################################################//
//		文件名 : QCHardCodeViewController.m
// ################################################################################//
/*!
 @file		QCHardCodeViewController.m
 @brief		硬代码实现旋转的视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCHardCodeViewController.h"
@interface QCHardCodeViewController ()

@property (retain, nonatomic) IBOutlet UIImageView *imgBG;
@property (retain, nonatomic) IBOutlet UIImageView *imgBrother;
@property (retain, nonatomic) IBOutlet UIImageView *imgSister;
@property (retain, nonatomic) IBOutlet UIImageView *imgWoman;
@property (retain, nonatomic) IBOutlet UIImageView *imgBGStone;
@property (retain, nonatomic) IBOutlet UILabel     *labTitleBro;
@property (retain, nonatomic) IBOutlet UILabel     *labTitleSis;
@property (retain, nonatomic) IBOutlet UILabel     *labTitleWom;
@end

@implementation QCHardCodeViewController
@synthesize imgBG, imgBrother,imgBGStone,imgSister,imgWoman;
@synthesize labTitleBro,labTitleSis,labTitleWom;

- (void)dealloc
{
    SAFE_RELEASE(imgBG)
    SAFE_RELEASE(imgBrother)
    SAFE_RELEASE(imgBGStone)
    SAFE_RELEASE(imgSister)
    SAFE_RELEASE(imgWoman)
    SAFE_RELEASE(labTitleBro)
    SAFE_RELEASE(labTitleSis)
    SAFE_RELEASE(labTitleWom)

    [super dealloc];
}

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    LOG_CURRENT_METHOD;
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}
#endif

#pragma mark -
#pragma mark Rotation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    LOG_CURRENT_METHOD;
    [self printFrame];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    LOG_CURRENT_METHOD;
    [self printFrame];
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        
        //
        //背景
        self.imgBG.frame = CGRectMake(0.0f,
                                      0.0f,
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.view.bounds));
        
        //
        //大师兄
        self.imgBrother.frame = CGRectMake(8.0f,
                                           8.0f,
                                           CGRectGetWidth(self.imgBrother.frame),
                                           CGRectGetHeight(self.imgBrother.frame));
        //相对位置的写法
        self.labTitleBro.frame = CGRectMake(CGRectGetMinX(self.imgBrother.frame),
                                            CGRectGetMaxY(self.imgBrother.frame) + 8.0f,
                                            CGRectGetWidth(self.imgBrother.frame),
                                            CGRectGetHeight(self.labTitleBro.frame));
        
        //
        //小师妹
        self.imgSister.frame = CGRectMake(CGRectGetMinX(self.imgBrother.frame),
                                          257.0f,
                                          CGRectGetWidth(self.imgSister.frame),
                                          CGRectGetHeight(self.imgSister.frame));
        //相对位置
        self.labTitleSis.frame = CGRectMake(CGRectGetMinX(self.imgSister.frame),
                                            CGRectGetMaxY(self.imgSister.frame) + 8.0f,
                                            CGRectGetWidth(self.imgSister.frame),
                                            CGRectGetHeight(self.labTitleSis.frame));
        
        //
        //大师姐
        //相对位置
        self.imgWoman.frame = CGRectMake(CGRectGetMaxX(self.imgSister.frame),
                                         CGRectGetMinY(self.imgSister.frame),
                                         CGRectGetWidth(self.imgWoman.frame),
                                         CGRectGetHeight(self.imgWoman.frame));
        //中心位置
        self.labTitleWom.center = CGPointMake(self.imgWoman.center.x,
                                              self.labTitleSis.center.y);
        
        
        //
        //碎石堆
        float startX      = CGRectGetMaxX(self.imgBrother.frame) + 42.0f;
        float endY        = CGRectGetMinY(self.imgWoman.frame) - 8.0f;
        
        self.imgBGStone.frame = CGRectMake(startX,
                                           0.0f,
                                           320.0f - startX,
                                           endY);
        
    }
    else{
        //
        //
        //背景
        self.imgBG.frame = CGRectMake(0.0f,
                                      0.0f,
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.view.bounds));
        
        //
        //大师兄
        self.imgBrother.frame = CGRectMake(8.0f,
                                           8.0f,
                                           CGRectGetWidth(self.imgBrother.frame),
                                           CGRectGetHeight(self.imgBrother.frame));
        //相对位置的写法
        self.labTitleBro.frame = CGRectMake(CGRectGetMinX(self.imgBrother.frame),
                                            CGRectGetMaxY(self.imgBrother.frame) + 0.0f,
                                            CGRectGetWidth(self.imgBrother.frame),
                                            CGRectGetHeight(self.labTitleBro.frame));
        
        //
        //小师妹
        self.imgSister.frame = CGRectMake(CGRectGetMinX(self.imgBrother.frame),
                                          150.0f,
                                          CGRectGetWidth(self.imgSister.frame),
                                          CGRectGetHeight(self.imgSister.frame));
        //相对位置
        self.labTitleSis.frame = CGRectMake(CGRectGetMinX(self.imgSister.frame),
                                            CGRectGetMaxY(self.imgSister.frame) + 0.0f,
                                            CGRectGetWidth(self.imgSister.frame),
                                            CGRectGetHeight(self.labTitleSis.frame));
        
        //
        //大师姐
        //相对位置
        self.imgWoman.frame = CGRectMake(CGRectGetMaxX(self.imgSister.frame),
                                         CGRectGetMinY(self.imgSister.frame),
                                         CGRectGetWidth(self.imgWoman.frame),
                                         CGRectGetHeight(self.imgWoman.frame));
        //中心位置
        self.labTitleWom.center = CGPointMake(self.imgWoman.center.x,
                                              self.labTitleSis.center.y);
        
        
        //
        //碎石堆
        float startX  = CGRectGetMaxX(self.imgBrother.frame) + 42.0f;
        float endY    = CGRectGetMinY(self.imgWoman.frame) - 8.0f;
        self.imgBGStone.frame = CGRectMake(startX,
                                           0.0f,
                                           480.0f - startX,
                                           endY);
    }

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{    
    NSString *devOri = nil;
    switch ([UIDevice currentDevice].orientation) {
        case UIInterfaceOrientationPortrait:
            devOri = @"竖屏（Home键在下）";
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            devOri = @"竖屏（Home键在上）";
            break;
        case UIInterfaceOrientationLandscapeLeft:
            devOri = @"横屏（Home键在左）";
            break;
        case UIInterfaceOrientationLandscapeRight:
            devOri = @"横屏（Home键在右）";
            break;
        default:
            devOri = @"未知设备方向";
            break;
    }
    
    NSLog(@"\n当前设备方向：[%@]。\n根视图的Frame属性：[%@]\n根视图的bounds属性：[%@]",
          devOri,
          [NSValue valueWithCGRect:self.view.frame],
          [NSValue valueWithCGRect:self.view.bounds]);
    
    LOG_CURRENT_METHOD;
    [self printFrame];
}

- (void)printFrame
{
    NSLog(@"%@",
          [NSString stringWithFormat:
           @"\n背景:[%@]\n"
           @"大师兄:[%@]\n"
           @"大师兄标题:[%@]\n"
           @"小师妹:[%@]\n"
           @"小师妹标题:[%@]\n"
           @"大师姐:[%@]\n"
           @"大师姐标题:[%@]\n"
           @"碎石堆:[%@]",
           [NSValue valueWithCGRect:self.imgBG.frame],
           [NSValue valueWithCGRect:self.imgBrother.frame],
           [NSValue valueWithCGRect:self.labTitleBro.frame],
           [NSValue valueWithCGRect:self.imgSister.frame],
           [NSValue valueWithCGRect:self.labTitleSis.frame],
           [NSValue valueWithCGRect:self.imgWoman.frame],
           [NSValue valueWithCGRect:self.labTitleWom.frame],
           [NSValue valueWithCGRect:self.imgBGStone.frame]]
          );
}

@end
