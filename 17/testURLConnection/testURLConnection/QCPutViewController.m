// ################################################################################//
//		文件名 : QCPutViewController.m
// ################################################################################//
/*!
 @file		QCPutViewController.m
 @brief		Put方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/15     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCPutViewController.h"
#import "QCAppDelegate.h"

@interface QCPutViewController ()
@property (nonatomic, readonly) BOOL              isSending;
@property (nonatomic, retain)   NSInputStream *   fileStream;
@end

#define TEST_SERVER     @"http://localhost:9000/"
#define PUT_PICT_NAME   @"China"

@implementation QCPutViewController
{
    NSURLConnection         *_connection;
    NSString                *_errInfo;
}

@synthesize urlText;
@synthesize imgPut;
@synthesize btnPut;
@synthesize status;
@synthesize fileStream = _fileStream;

#pragma mark -
#pragma makr UIViewController overrie
- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.urlText = nil;
    self.imgPut = nil;
    self.btnPut = nil;
    self.status = nil;
}

- (void)dealloc
{
    if (_connection) {
        [_connection cancel];
    }
    
    SAFE_RELEASE(_connection);
    SAFE_RELEASE(_errInfo);
    SAFE_RELEASE(_fileStream);

    [[QCAppDelegate sharedAppDelegate] didStopNetworking];
    
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.urlText resignFirstResponder];
    return NO;
}

- (void)initUI {
    self.urlText.text           = TEST_SERVER;
    self.status.text            = @"点击按钮进行上图Put"; 
    self.imgPut.image           = [UIImage imageNamed:PUT_PICT_NAME];

}

- (BOOL)isSending {
    return (_connection != nil);
}


- (void)startPut
{
    NSURL                   *url;
    NSMutableURLRequest     *request;
    NSNumber                *contentLength;
    NSString                *putFilePath = @"XXXX";
    
    putFilePath = [[NSBundle mainBundle] pathForResource:PUT_PICT_NAME
                                                  ofType:@"png"];
    if (!putFilePath) {
        self.status.text = @"Invalid Source File";
        return;
    }
    
    url = [[QCAppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
    if (url) {
        url = [url URLByAppendingPathComponent:[putFilePath lastPathComponent]];
    }
    
    
    if ( !url) {
        self.status.text = @"Invalid URL";
    }
    else {
        //将本地文件读到一个文件流中作为NSURLRequest的参数
        self.fileStream = [NSInputStream inputStreamWithFileAtPath:putFilePath];  
        
        //创建NSURLRequest对象
        request = [NSMutableURLRequest requestWithURL:url];
        //设置HTTP的提交方式
        [request setHTTPMethod:@"PUT"];
        //设置提交的内容，这里就是我们之前读取的文件流
        [request setHTTPBodyStream:self.fileStream];
        
        //设置HTTP头信息中的“Content-Type”内容
        //告诉服务端我们上传的内容是什么格式的文件。
        if ( [putFilePath.pathExtension isEqual:@"png"] ) {
            [request setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
        } else if ( [putFilePath.pathExtension isEqual:@"jpg"] ) {
            [request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
        } else if ( [putFilePath.pathExtension isEqual:@"gif"] ) {
            [request setValue:@"image/gif" forHTTPHeaderField:@"Content-Type"];
        } else {

        }
        
        //设置HTTP头信息中的"Content-Length"内容
        //告诉服务端我们上传的内容有多大。
        contentLength = (NSNumber *) [[[NSFileManager defaultManager] attributesOfItemAtPath:putFilePath 
                                                                                       error:NULL] 
                                      objectForKey:NSFileSize];
        [request setValue:[contentLength description] forHTTPHeaderField:@"Content-Length"];
        
        self.status.text = @"Receiving";
        [self.btnPut setTitle:@"Stop" forState:UIControlStateNormal];
        //发起请求
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
        
        self.status.text = @"接受中...";
        [self.btnPut setTitle:@"停止" forState:UIControlStateNormal];
        [[QCAppDelegate sharedAppDelegate] didStartNetworking];
    }
}

- (void)stopConnection
{
    if (_connection != nil) {
        [_connection cancel];
    }
    SAFE_RELEASE(_connection);
    
    if (_errInfo == nil){
        self.status.text = @"PUT 成功";
    }
    else {
        self.status.text = _errInfo;
    }
    
    SAFE_RELEASE(_errInfo);
    [self.btnPut setTitle:@"Put" forState:UIControlStateNormal];
    [[QCAppDelegate sharedAppDelegate] didStopNetworking];
}

#pragma mark -
#pragma mark action
- (IBAction)putTest:(id)sender
{
    if (self.isSending) {
        _errInfo = [@"Cancelled" retain];
        [self stopConnection];
    } 
    else {
        [self startPut];
    }
}

#pragma mark -
#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * httpResponse;
    httpResponse = (NSHTTPURLResponse *) response;
    
    if ((httpResponse.statusCode / 100) != 2) {
        _errInfo = [[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode] retain];
        [self stopConnection];
    } 
    else {
        self.status.text = @"有HTTP响应";
        return;
    }    
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    _errInfo = [[NSString stringWithFormat:@"error %@", error.localizedDescription] retain];
    [self stopConnection];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{    
    [self stopConnection];
}

@end