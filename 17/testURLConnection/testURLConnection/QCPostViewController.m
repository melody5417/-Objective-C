// ################################################################################//
//		文件名 : QCPostViewController.m
// ################################################################################//
/*!
 @file		QCPostViewController.m
 @brief		Post方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/15     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCPostViewController.h"
#import "QCAppDelegate.h"

@interface QCPostViewController ()
@property (nonatomic, readonly) BOOL              isSending;
@property (nonatomic, retain)   NSInputStream *   fileStream;
@end

#define TEST_SERVER         @"http://localhost:9000/cgi-bin/PostIt.py"
#define POST_PICT_NAME      @"China"

@implementation QCPostViewController
{
    NSURLConnection         *_connection;
    NSString                *_errInfo;
}

@synthesize urlText;
@synthesize imgPost;
@synthesize btnPost;
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
    
    self.urlText    = nil;
    self.imgPost    = nil;
    self.btnPost    = nil;
    self.status     = nil;
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
    self.status.text            = @"点击按钮进行上图Post"; 
    self.imgPost.image          = [UIImage imageNamed:POST_PICT_NAME];
    
}

- (BOOL)isSending {
    return (_connection != nil);
}

#pragma mark -
#pragma mark -multipart/form-data post
- (NSString *)generateBoundaryString
{
    CFUUIDRef       uuid;
    CFStringRef     uuidStr;
    NSString *      result;
    
    //创建UUID
    uuid    = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    //转化成通用格式
    result = [NSString stringWithFormat:@"Boundary-%@", uuidStr];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

- (BOOL)appendValue:(NSString*)postParamVal
           paramKey:(NSString*)postParamKey
           boundary:(NSString*)postBoundary
         toPostData:(NSMutableData*)postData
{
    if (!postParamVal || !postParamKey || !postBoundary || !postData) {
        return FALSE;
    }
    
    NSString *strTmp = nil;
    //1
    strTmp = [NSString stringWithFormat:@"--%@\r\n", postBoundary];
    [postData appendData:[strTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //2
    strTmp = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", postParamKey];
    [postData appendData:[strTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //3
    strTmp = [NSString stringWithFormat:@"%@\r\n", postParamVal];
    [postData appendData:[strTmp dataUsingEncoding:NSUTF8StringEncoding]];

    return TRUE;
}

- (BOOL)appendFile:(NSString*)filePath
          boundary:(NSString*)postBoundary
        toPostData:(NSMutableData*)postData
{
    if (!filePath || !postBoundary || !postData) {
        return FALSE;
    }
    
    NSString *strTmp            = nil;
    NSString *strContentType    = nil;
    NSString *strExtension      = nil;
    NSString *strFileExtension  = [filePath pathExtension];
    
    //检查是否支持的上传类型
    //可参阅HTML4.01规范文档“http://www.w3.org/TR/html4/types.html#h-6.7”
    //来新增支持文件类型
    //POST的 multipart/form-data类型返回值表单可以参考：
    //"http://www.ietf.org/rfc/rfc2388.txt"
    
    if ( [strFileExtension isEqual:@"png"] ) {
        strContentType = @"image/png";
        strExtension = @"png";
    } 
    else if ( [strFileExtension isEqual:@"jpg"] ) {
        strContentType = @"image/jpeg";
        strExtension = @"jpg";
    } 
    else if ( [strFileExtension isEqual:@"gif"] ) {
        strContentType = @"image/gif";
        strExtension = @"gif";
    } 
    else if ( [strFileExtension isEqual:@"txt"] ) {
        strContentType = @"text/plain";
        strExtension = @"txt";
    } 
    else {
        return FALSE;
    }
    
    NSData  *dataFile = [NSData dataWithContentsOfFile:filePath];
    if (!dataFile) {
        return FALSE;
    }
    
    //1
    strTmp = [NSString stringWithFormat:@"--%@\r\n", postBoundary];
    [postData appendData:[strTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //2
    strTmp = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.%@\"\r\n", @"fileContents", strExtension];
    [postData appendData:[strTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //3
    strTmp = [NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", strContentType];
    [postData appendData:[strTmp dataUsingEncoding:NSUTF8StringEncoding]];
    //4
    [postData appendData:dataFile];
    //5
    [postData appendData:
     [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    return TRUE;
}

- (void)startPostFormData
{
    NSURL *                 url;
    NSMutableURLRequest *   request;
    NSString *              boundaryStr;
    NSString                *postFilePath;
    NSMutableData           *postData = [NSMutableData dataWithCapacity:0];
    
    postFilePath = [[NSBundle mainBundle] pathForResource:POST_PICT_NAME
                                                  ofType:@"png"];
    if (!postFilePath) {
        self.status.text = @"Invalid Source File";
        return;
    }
        
    url = [[QCAppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
    if ( ! url) {
        self.status.text = @"Invalid URL";
    }
    else 
    {        
        boundaryStr = [self generateBoundaryString];   
        
        //HTTP Body
        if(![self appendValue:@"China I love you" 
                     paramKey:@"wantToSay" 
                     boundary:boundaryStr
                   toPostData:postData]) 
        {
            self.status.text = @"Param set to Post Failed.";
            return;
        }
        if(![self appendFile:postFilePath
                    boundary:boundaryStr
                  toPostData:postData]) 
        {
            self.status.text = @"Picture set to Post Failed.";
            return;        
        }

        //HTTP Body 收尾
        [postData appendData:
         [[NSString stringWithFormat:@"--%@--\r\n", boundaryStr] dataUsingEncoding:NSUTF8StringEncoding]];

        //HTTP Request
        request = [NSMutableURLRequest requestWithURL:url];        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=\"%@\"", boundaryStr]
       forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d", postData.length] 
       forHTTPHeaderField:@"Content-Length"];
        
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
        
        self.status.text = @"接受中...";
        [self.btnPost setTitle:@"停止" forState:UIControlStateNormal];
        [[QCAppDelegate sharedAppDelegate] didStartNetworking];
    }
}

#pragma mark -application/x-www-form-urlencoded post
- (void)startPostFormURL
{
    NSURL *                 url;
    NSMutableURLRequest *   request;
    NSString                *postFilePath;
    NSMutableString         *postContent = [NSMutableString stringWithCapacity:0];
    NSData                  *postBody    = nil;
    
    postFilePath = [[NSBundle mainBundle] pathForResource:POST_PICT_NAME
                                                   ofType:@"png"];
    if (!postFilePath) {
        self.status.text = @"Invalid Source File";
        return;
    }
    
    // First get and check the URL.
    url = [[QCAppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
    if ( ! url) {
        self.status.text = @"Invalid URL";
    }
    else 
    {        
        //HTTPBody的生成
        [postContent appendFormat:@"username=%@&password=%@", @"Rose", @"123456"];
        postBody = [postContent dataUsingEncoding:NSUTF8StringEncoding];
        
        //创建NSURLRequest
        request = [NSMutableURLRequest requestWithURL:url]; 
        //设置HTTP提交方式
        [request setHTTPMethod:@"POST"];
        //设置HTTP头信息中的“Content-Type”内容
        [request setHTTPBody:postBody];
        [request setValue:@"application/x-www-form-urlencoded"
       forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d", postBody.length]
       forHTTPHeaderField:@"Content-Length"];         //设置HTTP头信息中的“Content-Length”内容



        
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
        
        self.status.text = @"接受中...";
        [self.btnPost setTitle:@"停止" forState:UIControlStateNormal];
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
        self.status.text = @"POST 成功";
    }
    else {
        self.status.text = _errInfo;
    }
    
    SAFE_RELEASE(_errInfo);
    [self.btnPost setTitle:@"Post" forState:UIControlStateNormal];
    [[QCAppDelegate sharedAppDelegate] didStopNetworking];
}

#pragma mark -
#pragma mark action
- (IBAction)postTest:(id)sender
{
    if (self.isSending) {
        _errInfo = [@"Cancelled" retain];
        [self stopConnection];
    } 
    else {
        [self startPostFormData];
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