// ################################################################################//
//		文件名 : QCAutoResizeViewController.m
// ################################################################################//
/*!
 @file		QCAutoResizeViewController.m
 @brief		autoresize机制实现旋转的视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/27     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCAutoResizeViewController.h"

@interface QCAutoResizeViewController ()
@property (retain, nonatomic) IBOutlet UIImageView *imgBG;
@property (retain, nonatomic) IBOutlet UIImageView *imgBrother;
@property (retain, nonatomic) IBOutlet UIImageView *imgSister;
@property (retain, nonatomic) IBOutlet UIImageView *imgWoman;
@property (retain, nonatomic) IBOutlet UIImageView *imgBGStone;
@property (retain, nonatomic) IBOutlet UILabel     *labTitleBro;
@property (retain, nonatomic) IBOutlet UILabel     *labTitleSis;
@property (retain, nonatomic) IBOutlet UILabel     *labTitleWom;
@end

@implementation QCAutoResizeViewController
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
    
    CGRect  rectTmp = CGRectZero;
    CGPoint pntTmp  = CGPointZero;
    if (interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        
        //
        //小师妹
        rectTmp = self.imgSister.frame;
        rectTmp.origin.y = CGRectGetMaxY(self.labTitleBro.frame) + 115.0f;
        self.imgSister.frame = rectTmp;
        
        rectTmp = self.labTitleSis.frame;
        rectTmp.origin.y = CGRectGetMaxY(self.imgSister.frame) + 8.0f;
        self.labTitleSis.frame = rectTmp;
        
        //
        //大师姐
        pntTmp = self.imgWoman.center;
        pntTmp.y = self.imgSister.center.y;
        self.imgWoman.center = pntTmp;

        rectTmp = self.labTitleWom.frame;
        rectTmp.origin.y = CGRectGetMaxY(self.imgWoman.frame) + 8.0f;
        self.labTitleWom.frame = rectTmp;
        
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
        //小师妹
        rectTmp = self.imgSister.frame;
        rectTmp.origin.y = CGRectGetMaxY(self.labTitleBro.frame) - 4.0f;
        self.imgSister.frame = rectTmp;
        
        rectTmp = self.labTitleSis.frame;
        rectTmp.origin.y = CGRectGetMaxY(self.imgSister.frame) + 0.0f;
        self.labTitleSis.frame = rectTmp;
        
        //
        //大师姐
        pntTmp = self.imgWoman.center;
        pntTmp.y = self.imgSister.center.y;
        self.imgWoman.center = pntTmp;
        
        rectTmp = self.labTitleWom.frame;
        rectTmp.origin.y = CGRectGetMaxY(self.imgWoman.frame) + 0.0f;
        self.labTitleWom.frame = rectTmp;
        
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
