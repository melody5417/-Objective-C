// ################################################################################//
//		文件名 : QCViewController.m
// ################################################################################//
/*!
 @file		QCViewController.m
 @brief		显示视图类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/11/04     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCViewController.h"

@interface QCViewController() <NSMachPortDelegate>
@property(nonatomic, retain) NSMachPort *notificationPort;
@end

@implementation QCViewController {
    BOOL    _bFinishNotification;
}
@synthesize notificationPort;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"NotificationB"
                                               object:self];
    [NSThread detachNewThreadSelector:@selector(sendNotificationA)
                             toTarget:self
                           withObject:nil];
    [NSThread detachNewThreadSelector:@selector(sendNotificationB)
                             toTarget:self
                           withObject:nil];
}

- (void)sendNotificationA
{
    NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];
    
    //发送通知A
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationA"
                                                        object:nil
                                                      userInfo:@{@"key1" : @"Hello", @"key2" : @"Bye"}];
    
    [pool release];
}

- (void)sendNotificationB
{
    //发送通知B
    NSAutoreleasePool   *pool = [[NSAutoreleasePool alloc] init];

    _bFinishNotification = NO;
    
    self.notificationPort = [[[NSMachPort alloc] init] autorelease];
    [self.notificationPort setDelegate:self];
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(NSString *)kCFRunLoopDefaultMode];
    
    NSLog(@"add Notification to queue");
    [[NSNotificationQueue defaultQueue] enqueueNotification:[NSNotification notificationWithName:@"NotificationB" object:self]
                                               postingStyle:NSPostWhenIdle
                                               coalesceMask:NSNotificationNoCoalescing
                                                   forModes:[NSArray arrayWithObjects:NSRunLoopCommonModes, NSDefaultRunLoopMode, nil]];
    
    while (!_bFinishNotification) {
        [[NSRunLoop currentRunLoop] runMode:(NSString *)kCFRunLoopDefaultMode
                                 beforeDate:[NSDate distantFuture]];
    }
    
    NSLog(@"exit thread");
    [pool release];
}

- (void) handleMachMessage:(void *)msg {
    NSLog(@"port message received");
}

- (void)receiveNotification:(NSNotification*)aNotification
{
    _bFinishNotification = YES;
    NSLog(@"receive Notification");
    
    //打断while循环
    [self.notificationPort sendBeforeDate:[NSDate date]
                               components:nil
                                     from:nil
                                 reserved:0];
}

@end
