// ################################################################################//
//		文件名 : QCGetViewController.m
// ################################################################################//
/*!
 @file		QCGetViewController.m
 @brief		Get方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/13     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCGetViewController.h"
#import "QCAppDelegate.h"

@interface NSString (HTTPExtensions)
- (BOOL)isHTTPContentType:(NSString *)prefixStr;
@end

@implementation NSString (HTTPExtensions)
- (BOOL)isHTTPContentType:(NSString *)prefixStr
{
    BOOL    result;
    NSRange foundRange;
    
    result = NO;
    
    foundRange = [self rangeOfString:prefixStr options:NSAnchoredSearch | NSCaseInsensitiveSearch];
    if (foundRange.location != NSNotFound) {
        assert(foundRange.location == 0);            // because it's anchored
        if (foundRange.length == self.length) {
            result = YES;
        } else {
            unichar nextChar;
            
            nextChar = [self characterAtIndex:foundRange.length];
            result = nextChar <= 32 || nextChar >= 127 || (strchr("()<>@,;:\\<>/[]?={}", nextChar) != NULL);
        }
        /*
         From RFC 2616:
         
         token          = 1*<any CHAR except CTLs or separators>
         separators     = "(" | ")" | "<" | ">" | "@"
         | "," | ";" | ":" | "\" | <">
         | "/" | "[" | "]" | "?" | "="
         | "{" | "}" | SP | HT
         
         media-type     = type "/" subtype *( ";" parameter )
         type           = token
         subtype        = token
         */
    }
    return result;
}
@end

//远程文件资源
#define TEST_IMAGE_LINK @"http://ww1.sinaimg.cn/large/57435d41gw1dwxj9x8mvpj.jpg"
//#define TEST_IMAGE_LINK @"http://www.bxnfga.gov.cn/UploadFiles/2012-05/admin/2012050213583780987.jpg"

enum{
    kGetSynMode = 0,
    kGetAsynMode,
    kGetBlockMode
};

@interface QCGetViewController ()
@property (nonatomic, readonly) BOOL              isReceiving;
@property (nonatomic, assign)   BOOL              isFinishBlock;

@end
@implementation QCGetViewController
{
    NSMutableData           *_dataReceived;
    NSURLConnection         *_connection;
    NSString                *_errInfo;

}

@synthesize urlText;
@synthesize imgGet;
@synthesize btnGet;
@synthesize status;
@synthesize mode;
@synthesize isFinishBlock;

#pragma mark -
#pragma makr UIViewController overrie
- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    [self initUI];
    [self initVariables];
    
    [self resetUI];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.urlText = nil;
    self.imgGet = nil;
    self.btnGet = nil;
    self.status = nil;
    self.mode = nil;
}

- (void)dealloc
{
    if (_connection) {
        [_connection cancel];
    }
    
    SAFE_RELEASE(_connection);
    SAFE_RELEASE(_errInfo);
    SAFE_RELEASE(_dataReceived);
    
    [[QCAppDelegate sharedAppDelegate] didStopNetworking];

    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.urlText resignFirstResponder];
    return NO;
}

- (void)initUI {
    self.urlText.text           = TEST_IMAGE_LINK;
    self.status.text            = @"点击Get按钮开始取图片"; 
}

- (void)initVariables {
    _dataReceived = [[NSMutableData alloc] initWithCapacity:0];
    self.isFinishBlock = NO;
}


- (void)resetUI {
    self.imgGet.backgroundColor = [UIColor lightGrayColor];
    self.imgGet.image = nil;
}

- (void)resetVariables {
    if (_connection) {
        [_connection cancel];
    }
    
    SAFE_RELEASE(_connection);
    SAFE_RELEASE(_errInfo);
    SAFE_RELEASE(_dataReceived);
    
    [self initVariables];
}

- (BOOL)isReceiving {
    return (_connection != nil);
}

#pragma mark -
#pragma mark Get Method
- (void)startGetAsyn
{
    NSURL           *url         = nil;
    NSURLRequest    *request     = nil;
    
    // First get and check the URL.
    url = [[QCAppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    if ( !url) {
        _errInfo = [@"非法 URL" retain];
        [self stopConnection];
    } 
    else {
        // Open a connection for the URL.
        request = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
        
        self.status.text = @"接受中...";
        [self.btnGet setTitle:@"停止" forState:UIControlStateNormal];
        [[QCAppDelegate sharedAppDelegate] didStartNetworking];
    }
}

- (void)startGetSyn
{
    NSURL               *url            = nil;
    NSURLRequest        *request        = nil;
    NSURLResponse       *response       = nil;
    NSError             *error          = nil;
    NSData              *data           = nil;
    
    // First get and check the URL.
    url = [[QCAppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    if ( !url) {
        _errInfo = [@"非法 URL" retain];
    } 
    else {
        // Open a connection for the URL.
        request = [NSURLRequest requestWithURL:url];

        self.status.text = @"接受中...";
        [self.btnGet setTitle:@"停止" forState:UIControlStateNormal];
        [[QCAppDelegate sharedAppDelegate] didStartNetworking];
        
        data = [NSURLConnection sendSynchronousRequest:request
                                            returningResponse:&response
                                                        error:&error];
        
        if (data) {
            [_dataReceived appendData:data];
        }
        else {
            if (error) {
                _errInfo = [error localizedDescription];
            }
            else {
                _errInfo = [@"没获得数据" retain];
            }
        }
        
    }
    
    [self stopConnection];
}

- (void)startGetBlock
{
    NSURL               *url         = nil;
    NSURLRequest        *request     = nil;
    
    // First get and check the URL.
    url = [[QCAppDelegate sharedAppDelegate] smartURLForString:self.urlText.text];
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    if ( !url) {
        _errInfo = [@"非法 URL" retain];
    } 
    else {
        self.status.text = @"接受中...";
        [self.btnGet setTitle:@"停止" forState:UIControlStateNormal];
        [[QCAppDelegate sharedAppDelegate] didStartNetworking];
        
        // Open a connection for the URL.
        request     = [NSURLRequest requestWithURL:url];
        _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
        
        while(self.isFinishBlock == NO) {
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode 
									 beforeDate:[NSDate distantFuture]];
		}
        
    }
    
    [self stopConnection];
}

- (void)stopConnection
{    
    if (_connection != nil) {
        [_connection cancel];
    }
    SAFE_RELEASE(_connection);

    if (_errInfo == nil){
        if (_dataReceived) {
            self.imgGet.image = [UIImage imageWithData:_dataReceived];
            self.status.text = @"GET 成功";
        }
    }
    else {
        self.status.text = _errInfo;
    }
    
    SAFE_RELEASE(_errInfo);
    SAFE_RELEASE(_dataReceived);
    [self.btnGet setTitle:@"Get" forState:UIControlStateNormal];
    [[QCAppDelegate sharedAppDelegate] didStopNetworking];
}

#pragma mark -
#pragma mark action
- (IBAction)getImage:(id)sender
{
    if (self.isReceiving) {
        _errInfo = [@"Cancelled" retain];
        
        switch (mode.selectedSegmentIndex) {
            case kGetBlockMode:
                self.isFinishBlock = YES;
                break;
            default:
                [self stopConnection];
                break;
        }
    } 
    else {
        [self resetVariables];
        [self resetUI];
        
        switch (mode.selectedSegmentIndex) {
            case kGetSynMode:
                [self startGetSyn];
                break;
            case kGetAsynMode:
                [self startGetAsyn];
                break;
            case kGetBlockMode:
                [self startGetBlock];
                break;
            default:
                break;
        }
    }
}

#pragma mark -
#pragma mark NSURLConnection delegate
//服务器响应了我们的请求
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * httpResponse;
    NSString *          contentTypeHeader;
        
    httpResponse = (NSHTTPURLResponse *) response;
    
    //查看响应码
    //一般我们可以认为200~299的响应码为正常响应
    if ((httpResponse.statusCode / 100) != 2) {
        _errInfo = [[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode] retain];
    }
    else {
        //看一下我们下载的图片类型，服务器端是不是支持
        contentTypeHeader = [httpResponse.allHeaderFields objectForKey:@"Content-Type"];
        if (contentTypeHeader == nil) {
            _errInfo = [@"没有Content-Type内容" retain];
        } 
        else if (! [contentTypeHeader isHTTPContentType:@"image/jpeg"] && 
                 ! [contentTypeHeader isHTTPContentType:@"image/png"]  && 
                 ! [contentTypeHeader isHTTPContentType:@"image/gif"] ) {
            _errInfo= [[NSString stringWithFormat:@"Unsupported Content-Type (%@)", contentTypeHeader] retain];
        } 
        else {
            self.status.text = @"有HTTP响应";
            return;
        }
    }  
    
    if (mode.selectedSegmentIndex != kGetBlockMode) {
        [self stopConnection];
    }
    else {
        self.isFinishBlock = YES;
    }
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
    [_dataReceived appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    _errInfo = [[NSString stringWithFormat:@"error %@", error.localizedDescription] retain];
    if (mode.selectedSegmentIndex != kGetBlockMode) {
        [self stopConnection];
    }
    else {
        self.isFinishBlock = YES;
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{    
    if (mode.selectedSegmentIndex != kGetBlockMode) {
        [self stopConnection];
    }
    else {
        self.isFinishBlock = YES;
    }
}

@end