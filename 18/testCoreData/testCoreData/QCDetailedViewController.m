// ################################################################################//
//		文件名 : QCDetailedViewController.m
// ################################################################################//
/*!
 @file		QCDetailedViewController.m
 @brief		球员的详细信息视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/12/17     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCDetailedViewController.h"

@implementation QCDetailedViewController
@synthesize nameTextField;
@synthesize photoButton;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];    
}

#pragma mark -
#pragma mark iOS6.0 prior
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark iOS6.0 later
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return YES;
}


//界面初始化
- (void)initUI {
    //导航栏左边是“取消”
    UIBarButtonItem *leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                        action:@selector(actCancel:)] autorelease];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    //右边是“保存”
    UIBarButtonItem *rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                         target:self
                                                                                         action:@selector(actSave:)] autorelease];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    //头像和名字的预设
    if (self.playerInfo ) {
        if (self.playerInfo.image) {
            [self.photoButton setImage:self.playerInfo.image
                              forState:UIControlStateNormal];
        }
        
        self.nameTextField.text = self.playerInfo.name;
    }
}

#pragma mark -
#pragma mark Action
- (IBAction)actCancel:(id)sender
{
    if (self.delegate) {
        [self.delegate cancelDetailedInfo:self];
    }
}

- (IBAction)actSave:(id)sender
{
    if (self.delegate) {
        [self.delegate saveDetailedInfo:self];
    }
}

- (IBAction)actChooseImage:(id)sender
{
    UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
    imagePicker.delegate        = self;
    imagePicker.allowsEditing   = YES;
    imagePicker.sourceType      = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //系统相册
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

#pragma mark -
#pragma mark ImagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //图片选择完毕
    UIImage *newPhoto = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //设置
    if (newPhoto) {
        [self.photoButton setImage:newPhoto forState:UIControlStateNormal];
    }
    
    //关闭
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
