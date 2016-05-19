// ################################################################################//
//		文件名 : AppDelegate.m
// ################################################################################//
/*!
 @file		AppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/28     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "AppDelegate.h"
#import <Carbon/Carbon.h>

@implementation AppDelegate
@synthesize window = _window;

- (void)dealloc {
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (BOOL)windowShouldClose:(id)sender {
	[NSApp terminate:self];
	return YES;
}

- (IBAction)actShowQuickAlert:(id)sender
{
    NSInteger selection   = NSRunInformationalAlertPanel(@"我是标题",
                                                         @"我是内容", 
                                                         @"确定",
                                                         @"取消", 
                                                         @"其他");
    
    switch (selection) {
        case NSAlertAlternateReturn:
            NSLog(@"我选择了[取消]按钮");
            break;     
        case NSAlertOtherReturn:
            NSLog(@"我选择了[其他]按钮");
            break;  
        default:
            NSLog(@"我选择了[确定]按钮");
            break;
    }
}

- (IBAction)actShowNormalAlert1:(id)sender
{
    NSInteger   selection   = 0;
    NSAlert     *alert      = [NSAlert alertWithMessageText:@"我是标题" 
                                              defaultButton:@"确定" 
                                            alternateButton:@"取消" 
                                                otherButton:@"其他"
                                  informativeTextWithFormat:@"我是内容"];
    selection = [alert runModal];
 
    switch (selection) {
        case NSAlertAlternateReturn:
            NSLog(@"我选择了[取消]按钮");
            break;     
        case NSAlertOtherReturn:
            NSLog(@"我选择了[其他]按钮");
            break;  
        default:
            NSLog(@"我选择了[确定]按钮");
            break;
    }
}

- (IBAction)actShowNormalAlert2:(id)sender
{
    NSInteger       selection   = 0;
    NSAlert         *alert      = [[NSAlert alloc] init];
    
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"我是标题"];
    [alert setInformativeText:@"我是内容"];
    [alert addButtonWithTitle:@"第1个按钮"];
    [alert addButtonWithTitle:@"第2个按钮"];
    [alert addButtonWithTitle:@"第3个按钮"];
    [alert addButtonWithTitle:@"第4个按钮"];
    
    selection = [alert runModal];
    
    switch (selection) {
        case NSAlertFirstButtonReturn:
            NSLog(@"我选择了[第1个按钮]");
            break;     
        case NSAlertSecondButtonReturn:
            NSLog(@"我选择了[第2个按钮]");
            break;  
        case NSAlertThirdButtonReturn:
            NSLog(@"我选择了[第3个按钮]");
            break; 
        case (NSAlertThirdButtonReturn+1):
            NSLog(@"我选择了[第4个按钮]");
            break; 
        default:
            NSLog(@"我选择了[奇怪的]按钮");
            break;
    }
    [alert release];
}

- (IBAction)actShowNormalAlert3:(id)sender
{
    NSInteger		retValue	= 0;
    NSPanel			*panel		= nil;
	NSModalSession session		= 0;
    
	panel = NSGetAlertPanel(@"我是标题",
							@"我是内容",
							@"确定",
							@"取消",	
							@"其他");
    
	session = [NSApp beginModalSessionForWindow:panel];
	for (;;)
	{
        
		if ((retValue = [NSApp runModalSession:session]) != NSRunContinuesResponse)	{
			[panel close];
			break;
		}
	}
	
	[NSApp endModalSession:session];
	if(panel != nil) {
		NSReleaseAlertPanel(panel);
	}
    
    switch (retValue) {
        case NSAlertAlternateReturn:
            NSLog(@"我选择了[取消]按钮");
            break;     
        case NSAlertOtherReturn:
            NSLog(@"我选择了[其他]按钮");
            break;  
        default:
            NSLog(@"我选择了[确定]按钮");
            break;
    }
}

- (IBAction)actShowAlertSheet:(id)sender
{
    NSAlert     *alert      = [[[NSAlert alloc] init] autorelease];
    
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"我是标题"];
    [alert setInformativeText:@"我是内容"];
    [alert addButtonWithTitle:@"第1个按钮"];
    [alert addButtonWithTitle:@"第2个按钮"];
    
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self
                     didEndSelector:@selector(alertDidEnd: returnCode: contextInfo:) 
                        contextInfo:@"你好呀"];
}
     
//代理方法
- (void) alertDidEnd:(NSAlert *)alert 
          returnCode:(NSInteger)returnCode 
         contextInfo:(void *)contextInfo
{
    if (contextInfo) {
        NSLog(@"收到代理方法：[%@]", contextInfo);
    }
    switch (returnCode) {
        case NSAlertFirstButtonReturn:
            NSLog(@"我选择了[第1个按钮]");
            break;     
        case NSAlertSecondButtonReturn:
            NSLog(@"我选择了[第2个按钮]");
            break;  
        case NSAlertThirdButtonReturn:
            NSLog(@"我选择了[第3个按钮]");
            break; 
        case (NSAlertThirdButtonReturn+1):
            NSLog(@"我选择了[第4个按钮]");
            break; 
        default:
            NSLog(@"我选择了[奇怪的]按钮");
            break;
    }
}

- (IBAction)actShowAccessoryAlert:(id)sender
{
    NSTextView  *accessory          = [[NSTextView alloc] initWithFrame:NSMakeRect(0,0,200,15)];
    NSFont      *font               = [NSFont systemFontOfSize:[NSFont systemFontSize]];
    NSDictionary *textAttributes    = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [accessory insertText:[[NSAttributedString alloc] initWithString:@"测试辅助内容"
                                                          attributes:textAttributes]];
    [accessory setEditable:NO];
    accessory.backgroundColor = [NSColor greenColor];
    
    NSAlert     *alert      = [[[NSAlert alloc] init] autorelease];
    
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"我是标题"];
    [alert setInformativeText:@"我是内容"];
    [alert addButtonWithTitle:@"第1个按钮"];
    [alert addButtonWithTitle:@"第2个按钮"];
    [alert setAccessoryView:accessory];
    [alert runModal];
}


- (IBAction)actShowCheckBoxAlert:(id)sender
{
    NSAlert     *alert      = [[[NSAlert alloc] init] autorelease];
    
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setMessageText:@"我是标题"];
    [alert setInformativeText:@"我是内容"];
    [alert addButtonWithTitle:@"第1个按钮"];
    [alert addButtonWithTitle:@"第2个按钮"];
    [alert setShowsSuppressionButton:YES];
    [[alert suppressionButton] setTitle:@"下次不再显示"];
    [alert runModal];
    
    if ([[alert suppressionButton] state] == NSOnState) {
        //记录不再显示此警告框的值，下次控制
    }
}

#pragma mark -
#pragma mark NSSheet
- (IBAction)actShowSheet:(id)sender
{
    NSWindow *window = [[NSWindow alloc] initWithContentRect:CGRectMake(0.0f, 
                                                                        0.0f, 
                                                                        213.0f, 
                                                                        107.0f) 
                                                   styleMask:NSTitledWindowMask
                                                     backing:NSBackingStoreBuffered 
                                                       defer:YES];
    NSProgressIndicator *indicator = [[NSProgressIndicator alloc] init];
    indicator.style = NSProgressIndicatorSpinningStyle;
    [[window contentView] addSubview:indicator];
    indicator.frame = CGRectMake(CGRectGetWidth(((NSView*)[window contentView]).bounds)/2 - 16, 
                                 CGRectGetHeight(((NSView*)[window contentView]).bounds)/2 - 16,
                                 32.0f, 
                                 32.0f);
    [indicator startAnimation:nil];
    
    [NSApp beginSheet:window
       modalForWindow:self.window
        modalDelegate:nil
       didEndSelector:nil
          contextInfo:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(stopIndicator:) 
                                   userInfo:window
                                    repeats:NO];
}

- (void)stopIndicator:(NSTimer*)aTimer
{
    NSWindow *window = aTimer.userInfo;
    [window close];
    [NSApp endSheet:window];
}

- (IBAction)actShowCarbonAlert:(id)sender
{
    DialogRef			theItem;
    DialogItemIndex 	itemIndex;
    
    struct AlertStdCFStringAlertParamRec param = { 
            kStdCFStringAlertVersionTwo,
            NO,
            YES,
            CFSTR("默认"),
            CFSTR("取消"),
            CFSTR("其他"),
            kAlertStdAlertCancelButton,
            kAlertStdAlertOtherButton,
            kWindowDefaultPosition,
            0};
    
	CreateStandardAlert(kAlertNoteAlert,  
                        CFSTR("我是标题"), 
                        CFSTR("我是内容"),  
                        &param, 
                        &theItem);
    RunStandardAlert (theItem, NULL, &itemIndex);
}

@end
