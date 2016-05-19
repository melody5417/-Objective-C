//
//  ViewController.m
//  testAnimation
//
//  Created by Jason Qian on 10/3/12.
//  Copyright (c) 2012 PWC. All rights reserved.
//

#import "QCViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "QCGeneralViewAnimationController.h"
#import "QCCAViewAnimationController.h"
#import "QCCAViewPrivateAnimationController.h"
#import "QCBounceAnimationViewController.h"
#import "QCThreeDAnimationViewController.h"

@implementation QCViewController
{
    QCGeneralViewAnimationController    *generalVC;
    QCCAViewAnimationController         *CAAnimationVC;
    QCCAViewPrivateAnimationController  *CAPrivateAnimationVC;
    
    QCBounceAnimationViewController     *bounceAnimationVC;
    QCThreeDAnimationViewController     *threeDAnimationVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)dealloc
{
    SAFE_RELEASE(generalVC);
    SAFE_RELEASE(CAAnimationVC);
    SAFE_RELEASE(CAPrivateAnimationVC);
    
    SAFE_RELEASE(bounceAnimationVC);
    SAFE_RELEASE(threeDAnimationVC);

    [super dealloc];
}

#pragma mark -
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel	*labHeaderView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 
                                                                        0.0f,
                                                                        320, 
                                                                        40)] autorelease];
    
    if (section == 0) {
        labHeaderView.text					= @"     转场动画";
    }
    else {
        labHeaderView.text					= @"     单个视图自己玩";
    }
    labHeaderView.textColor				= [UIColor darkGrayColor];
    labHeaderView.shadowColor			= [UIColor lightGrayColor];
    labHeaderView.shadowOffset			= CGSizeMake(1.0f, 1.0f);
    labHeaderView.font					= [UIFont fontWithName:@"STHeitiJ-Medium" size:15.0f];
    labHeaderView.backgroundColor		= [UIColor clearColor];
    
    return labHeaderView;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                if (!generalVC) {
                    generalVC = [[QCGeneralViewAnimationController alloc] initWithNibName:@"QCGeneralViewAnimationController" 
                                                                                 bundle:nil];
                }
                
                generalVC.isBlockAnimation = NO;
                [self.navigationController pushViewController:generalVC
                                                     animated:YES];
                break;
            case 1:
                if (!generalVC) {
                    generalVC = [[QCGeneralViewAnimationController alloc] initWithNibName:@"QCGeneralViewAnimationController" 
                                                                                 bundle:nil];
                }
                
                generalVC.isBlockAnimation = YES;
                [self.navigationController pushViewController:generalVC
                                                     animated:YES];
                break;
            case 2:
                if (!CAAnimationVC) {
                    CAAnimationVC = [[QCCAViewAnimationController alloc] initWithNibName:@"QCCAViewAnimationController" 
                                                                                bundle:nil];
                }
                
                [self.navigationController pushViewController:CAAnimationVC
                                                     animated:YES];
                break;
            case 3:
                if (!CAPrivateAnimationVC) {
                    CAPrivateAnimationVC = [[QCCAViewPrivateAnimationController alloc] initWithNibName:@"QCCAViewPrivateAnimationController" 
                                                                                bundle:nil];
                }
                
                [self.navigationController pushViewController:CAPrivateAnimationVC
                                                     animated:YES];
                break;
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
                if (!bounceAnimationVC) {
                    bounceAnimationVC = [[QCBounceAnimationViewController alloc] initWithNibName:@"QCBounceAnimationViewController" 
                                                                                 bundle:nil];
                }
                
                [self.navigationController pushViewController:bounceAnimationVC
                                                     animated:YES];
                break;
            case 1:
                if (!threeDAnimationVC) {
                    threeDAnimationVC = [[QCThreeDAnimationViewController alloc] initWithNibName:@"QCThreeDAnimationViewController" bundle:nil];
                }
                
                [self.navigationController pushViewController:threeDAnimationVC
                                                     animated:YES];
                break;
            default:
                break;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
    return 40;
}
#pragma mark -
#pragma UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    NSString        *strTitle   = nil;
    UITableViewCell *cell       = nil;
    
    
    cell =  (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:cellID] autorelease];
        cell.layer.cornerRadius			= 20.0f;
        cell.backgroundColor			= [UIColor whiteColor];
        cell.textLabel.font				= [UIFont fontWithName:@"STHeitiJ-Light" size:14.0f];
        cell.textLabel.numberOfLines	= 2;
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                strTitle = @"普通视图动画";
                break;
            case 1:
                strTitle = @"普通视图动画块";
                break;
            case 2:
                strTitle = @"普通CATranstion动画";
                break;
            case 3:
                strTitle = @"私有CATranstion动画";
                break;
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
                strTitle = @"2D动画举例";
                break;
            case 1:
                strTitle = @"3D动画举例";
                break;
            default:
                break;
        }
    }

    cell.textLabel.text = strTitle;
    return cell;
    
}

@end
