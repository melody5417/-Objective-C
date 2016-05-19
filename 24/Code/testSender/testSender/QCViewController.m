// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/10     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"
#import "QCCustomActivity.h"

@interface QCViewController()<UIDocumentInteractionControllerDelegate, CustomActivityDelegate>
@end

@implementation QCViewController

#pragma mark -
#pragma mark Action
- (IBAction)openURLScheme:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ilovejason://I_Love_You!_Jason!!!"]];
}

- (IBAction)openJPG:(id)sender
{
	NSURL   *urlJPG = [[NSBundle mainBundle] URLForResource:@"testJPEG" withExtension:@"jpg"];
	if( urlJPG ){
        if (_docController) {
            [_docController release];
        }
        
		_docController = [[UIDocumentInteractionController interactionControllerWithURL:urlJPG] retain];
        //设置了额外的信息用户程序间传递
		_docController.annotation = [NSDictionary dictionaryWithObject:@"Anthony" forKey:@"AdditionInfo"];
		
		if ([_docController presentOptionsMenuFromRect:((UIButton*)sender).frame
                                                inView:self.view animated:YES]){
		}
		else{
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"openJPG"
                                                             message:@"没有支持JPG的程序"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil] autorelease];
            [alert show];
		}
	}
}

- (IBAction)openPNG:(id)sender
{
    NSURL   *urlPNG = [[NSBundle mainBundle] URLForResource:@"testPNG" withExtension:@"png"];
	if( urlPNG ){
        if (_docController) {
            [_docController release];
        }
        
		_docController = [[UIDocumentInteractionController interactionControllerWithURL:urlPNG] retain];
		_docController.annotation = [NSDictionary dictionaryWithObject:@"Dragon" forKey:@"AdditionInfo"];
		
        if ([_docController presentOpenInMenuFromRect:((UIButton*)sender).frame
                                               inView:self.view animated:YES]){
		}
		else{
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"openPNG"
                                                            message:@"没有支持PNG的第三方程序"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil] autorelease];
            [alert show];
		}
	}
}

- (IBAction)openPDF:(id)sender
{
    NSURL   *urlPDF = [[NSBundle mainBundle] URLForResource:@"testPDF" withExtension:@"pdf"];
	if( urlPDF ){
        if (_docController) {
            [_docController release];
        }
        
		_docController = [[UIDocumentInteractionController interactionControllerWithURL:urlPDF] retain];
		_docController.delegate = self;
		
        if ([_docController presentPreviewAnimated:YES]){
		}
		else{
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"openPDF"
                                                             message:@"打开PDF失败"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil] autorelease];
            [alert show];
		}
	}
}

- (IBAction)openCustomFileType:(id)sender
{
    NSURL   *urlLover = [[NSBundle mainBundle] URLForResource:@"heart" withExtension:@"lover"];
	if( urlLover ){
        if (_docController) {
            [_docController release];
        }
        
		_docController = [[UIDocumentInteractionController interactionControllerWithURL:urlLover]
                          retain];
		_docController.delegate = self;
		
        if ([_docController presentOptionsMenuFromRect:((UIButton*)sender).frame
                                                inView:self.view animated:YES]){
		}
		else{
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"openLover"
                                                             message:@"打开自定义文件类型失败"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil] autorelease];
            [alert show];
		}
	}
}

- (IBAction)openText:(id)sender
{
	if( ![UIActivityViewController class]){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"自定义openIn面板"
                                                         message:@"您的操作系统低于iOS6"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil] autorelease];
        [alert show];
		return;
	}
	
    UIActivityViewController *activityView = nil;
    
    activityView = [[[UIActivityViewController alloc] initWithActivityItems:
                                                            [NSArray arrayWithObjects:@"I Love Jason", nil]
                                                      applicationActivities:nil]
                    autorelease];
	
	[self presentViewController:activityView
                       animated:YES
                     completion:NULL];
}

- (IBAction)openTextAndImage:(id)sender
{
	if( ![UIActivityViewController class]){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"自定义openIn面板"
                                                         message:@"您的操作系统低于iOS6"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil] autorelease];
        [alert show];
		return;
	}
	
    UIActivityViewController *activityView = nil;
    
    activityView = [[[UIActivityViewController alloc] initWithActivityItems:
                     [NSArray arrayWithObjects:@"I Love Jason",
                      [UIImage imageNamed:@"testJPEG.jpg"],
                      [UIImage imageNamed:@"testPNGLittle.png"],
                      nil]
                                                      applicationActivities:nil]
                    autorelease];
	
	[self presentViewController:activityView
                       animated:YES
                     completion:NULL];
}

- (IBAction)actCustomActivity:(id)sender
{
    if( ![UIActivityViewController class]){
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"自定义openIn面板"
                                                         message:@"您的操作系统低于iOS6"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil] autorelease];
        [alert show];
        return;
    }
	
    QCCustomActivity *customAct = [[[QCCustomActivity alloc] init] autorelease];
    customAct.delegate = self;
	UIActivityViewController *activityView = [[[UIActivityViewController alloc] initWithActivityItems:
                                               [NSArray arrayWithObject:@"item1"]
                                                                                applicationActivities:
                                               [NSArray arrayWithObject:customAct]]
                                              autorelease];
	
	[self presentViewController:activityView
                       animated:YES
                     completion:NULL];
}

#pragma mark -
#pragma mark UIDocumentInteractionController delegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

#pragma mark -
#pragma mark CustomActivity delegate
- (void)finishTask:(QCCustomActivity*)anActivity
{
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}

@end
