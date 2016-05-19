// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/23     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@implementation QCViewController

- (void)dealloc {
    SAFE_RELEASE(_animationButton)
    SAFE_RELEASE(_completionBlock)
    [super dealloc];
}

#pragma mark -
#pragma mark Logic UnitTest
- (NSUInteger)add:(NSUInteger)numA toNumber:(NSUInteger)numB {
    return numA + numB;
}

- (NSUInteger)multiply:(NSUInteger)numA toNumber:(NSUInteger)numB {
    return numA * numB;
}

#pragma mark -
#pragma mark UI Unit Test
- (IBAction)actAnimateButton:(id)sender
{
    //动画
    [UIView animateWithDuration:0.5f
                     animations:^{
                         //平移
                         self.animationButton.center = CGPointMake(self.view.center.x,
                                                                   self.animationButton.center.y);
                     }
                     completion:^(BOOL finished) {
                         //回调
                         if (self.completionBlock) {
                             self.completionBlock();
                         }
                     }];
}

@end
