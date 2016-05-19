// ################################################################################//
//		文件名 : QCViewController.h
// ################################################################################//
/*!
 @file		QCViewController.h
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/23     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <UIKit/UIKit.h>

typedef void(^AnimationButtonCompletionBlock)();

@interface QCViewController : UIViewController

@property (retain,  nonatomic) IBOutlet UIButton *animationButton;
@property (copy,    nonatomic) AnimationButtonCompletionBlock completionBlock;

#pragma mark -
#pragma mark Logic Unit Test
- (NSUInteger)add:(NSUInteger)numA toNumber:(NSUInteger)numB;
- (NSUInteger)multiply:(NSUInteger)numA toNumber:(NSUInteger)numB;

#pragma mark -
#pragma mark UI Unit Test
- (IBAction)actAnimateButton:(id)sender;

@end
