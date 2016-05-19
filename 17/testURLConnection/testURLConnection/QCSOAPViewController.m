// ################################################################################//
//		文件名 : QCSOAPViewController.m
// ################################################################################//
/*!
 @file		QCSOAPViewController.m
 @brief		SOAP方法网络连接视图控制器
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/09/16     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCSOAPViewController.h"
#import "QCAppDelegate.h"

#define SHANGHAI_CITY_ID    @"2013"

@interface QCSOAPViewController ()<NSXMLParserDelegate>
{
    NSURLConnection         *_connection;
    NSString                *_errInfo;
    NSMutableData           *_dataReceived;
    NSMutableString         *_strInfo;
    NSMutableString         *_strTmp;
}

@property (nonatomic) BOOL elementFound;

- (NSString*)parserData:(NSData *)xmlData;
@end

@implementation QCSOAPViewController
@synthesize forcasInfo;
@synthesize shanghaiForcast;
@synthesize elementFound;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataReceived = [[NSMutableData alloc] initWithCapacity:0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.forcasInfo = nil;
    self.shanghaiForcast = nil;
}

- (void)dealloc
{
    if (_connection) {
        [_connection cancel];
    }
    SAFE_RELEASE(_connection);
    SAFE_RELEASE(_errInfo);
    SAFE_RELEASE(_dataReceived);
    SAFE_RELEASE(_strInfo);
    SAFE_RELEASE(_strTmp);
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)weatherForcast:(id)sender
{    
    NSMutableURLRequest *request    = nil;
    NSURL               *url        = nil;
    
    // 创建SOAP消息
    NSString *strSOAPContent = [NSString stringWithFormat:
                                @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                "<soap12:Envelope "
                                "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                                "<soap12:Body>"
                                "<getWeather xmlns=\"http://WebXml.com.cn/\">"
                                "<theCityCode>%@</theCityCode>"
                                "<theUserID>%@</theUserID>"
                                "</getWeather>"
                                "</soap12:Body>"
                                "</soap12:Envelope>", SHANGHAI_CITY_ID, @""];

    url     = [NSURL URLWithString: @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx"];
    request = [NSMutableURLRequest requestWithURL:url];

    //SOAP的HTTP头信息的Content-Type内容
    [request addValue:@"application/soap+xml; charset=utf-8" 
   forHTTPHeaderField:@"Content-Type"];
    //SOAP的HTTP头信息的Content-Length内容
    [request addValue:[NSString stringWithFormat:@"%d", strSOAPContent.length]
   forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[strSOAPContent dataUsingEncoding:NSUTF8StringEncoding]];
    
    SAFE_RELEASE(_dataReceived);
    _dataReceived = [[NSMutableData alloc] initWithCapacity:0];
    _connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];

    self.forcasInfo.text = @"接受中...";
    self.shanghaiForcast.enabled = NO;
    [[QCAppDelegate sharedAppDelegate] didStartNetworking];
    
}

- (void)stopConnection
{    
    if (_connection != nil) {
        [_connection cancel];
    }
    SAFE_RELEASE(_connection);
    
    if (_errInfo == nil){
        if (_dataReceived) {
            self.forcasInfo.text = [self parserData:_dataReceived];
        }
        else {
            self.forcasInfo.text = @"没有取到数据";
        }
    }
    else {
        self.forcasInfo.text = [NSString stringWithFormat:@"发生错误：[%@]", _errInfo];
    }
    
    SAFE_RELEASE(_errInfo);
    SAFE_RELEASE(_dataReceived);
    self.shanghaiForcast.enabled = YES;
    [[QCAppDelegate sharedAppDelegate] didStopNetworking];
}

- (NSString*)parserData:(NSData *)xmlData
{		
	if (xmlData == nil) {
		return NO;
	}
	
	NSError		*error		= nil;
	NSXMLParser *xmlParser	= [[NSXMLParser alloc] initWithData:xmlData];
	
    //重置数据
    SAFE_RELEASE(_strInfo);
    SAFE_RELEASE(_strTmp);
    elementFound = NO;

    //开始解析
	[xmlParser setDelegate:self];
	if ([xmlParser parse] == FALSE) 
	{
		error = [xmlParser parserError];
		if (error) {
            _errInfo = [[error localizedDescription] retain];
        }
        else {
            _errInfo = [@"解析数据错误" retain];
        }
        
		SAFE_RELEASE(xmlParser);
		return _errInfo;
	}
	SAFE_RELEASE(xmlParser);
	
	return _strInfo;
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
        self.forcasInfo.text = @"有HTTP响应";
        return;
    }    
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
    [_dataReceived appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    _errInfo = [[NSString stringWithFormat:@"error %@", error.localizedDescription] retain];
    [self stopConnection];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{    
    [_dataReceived writeToFile:@"/Users/Jason/Desktop/weather.xml" 
                    atomically:YES];
    [self stopConnection];
}

#pragma mark -
#pragma mark NSXMLParser delegate
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict 
{
    if ([elementName isEqualToString:@"getWeatherResult"]) {
        //将容器盖子打开
        _strInfo = [[NSMutableString alloc] initWithCapacity:0];
        _strTmp = [[NSMutableString alloc] initWithCapacity:0];
    }
    else if ([elementName isEqualToString:@"string"]) {
        //将许可打开
        elementFound = YES;
    }    
    else if([elementName isEqualToString:@"getWeatherResponse"]){
        NSString *attrContent = [attributeDict objectForKey:@"xmlns"];
        if (attrContent) {
            NSLog(@"取得属性内容：[%@]", attrContent);
        }
    }
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        if (_strTmp) {
            [_strTmp appendString: string];
        }
        else{
            [parser abortParsing];
        }
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"string"]) {
        
        if (_strTmp) 
        {
            if (_strInfo) {
                [_strInfo appendFormat:@"[%@]\n", _strTmp];
                [_strTmp setString:@""];
            }
            else{
                [parser abortParsing];
                return;
            }
        }
        
        elementFound = NO;
    }   
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {

}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (!_errInfo) {
        _errInfo = [[parseError localizedDescription] retain];
    }
}


@end
