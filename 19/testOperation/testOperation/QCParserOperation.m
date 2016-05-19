// ################################################################################//
//		文件名 : QCParserOperation.m
// ################################################################################//
/*!
 @file		QCParserOperation.m
 @brief		XML分析工具类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "QCParserOperation.h"
#import "QCGameAppRecord.h"

@interface QCParserOperation () <NSXMLParserDelegate> {
    //回调成功Block
    SuccessBlock    _completionHandler;
    //回调失败Block
    ErrorBlock      _errorHandler;
    
    //请求URL
    NSURL           *_urlTopGame;
    //游戏列表
    NSMutableArray  *_arrGameAppRecords;
    
    //用于接收数据的成员量
    BOOL            _bDataReceivedOpen;
    NSMutableString *_strDataReceived;
    QCGameAppRecord *_appRecord;
}

@property (nonatomic, copy)     SuccessBlock    completionHandler;
@property (nonatomic, copy)     ErrorBlock      errorHandler;
@property (nonatomic, retain)   NSURL           *urlTopGame;
@end

@implementation QCParserOperation
@synthesize urlTopGame;
@synthesize completionHandler, errorHandler;

- (id)initWithURL:(NSURL *)url
completionHandler:(SuccessBlock)successBlock
        errHander:(ErrorBlock)errBlock
{
    self = [super init];
    if (self != nil)
    {
        self.urlTopGame         = url;
        self.completionHandler  = successBlock;
        self.errorHandler       = errBlock;
    }
    return self;
}

- (void)dealloc
{
    SAFE_RELEASE(_completionHandler);
    SAFE_RELEASE(_errorHandler);
    SAFE_RELEASE(_urlTopGame);
    
    [super dealloc];
}

- (void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
    NSData  *dataXML = nil;
    NSError *error   = nil;
	if (self.urlTopGame) {
        dataXML = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:self.urlTopGame]
                                        returningResponse:nil
                                                    error:&error];
        
        if (error) {
            if (self.errorHandler) {
                self.errorHandler(error);
            }
            
            [pool release];
            return;
        }
    }
    
    if (!dataXML) {
        if (self.errorHandler) {
            self.errorHandler([NSError errorWithDomain:@"ParserOperation"
                                                  code:0
                                              userInfo:[NSDictionary dictionaryWithObject:@"No Data available to Parser"
                                                                                   forKey:NSLocalizedDescriptionKey]]);
        }
        
        [pool release];
        return;
    }
    
    //清空重置
    SAFE_RELEASE(_arrGameAppRecords);
    _arrGameAppRecords = [[NSMutableArray alloc] initWithCapacity:0];
    SAFE_RELEASE(_strDataReceived);
    _strDataReceived   = [[NSMutableString alloc] initWithCapacity:0];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataXML];
	[parser setDelegate:self];
    [parser parse];
	
    if (![parser parserError]) {
        if (self.completionHandler) {
            self.completionHandler(_arrGameAppRecords);
        }
    }
    
    SAFE_RELEASE(_arrGameAppRecords);
    SAFE_RELEASE(_strDataReceived);
    SAFE_RELEASE(parser);
        
	[pool release];
}

#pragma mark -
#pragma mark RSS processing
//XML的节点
#define APPRECORD_ENTRY                     @"entry"
#define APPRECORD_NAME_ENTRY                @"im:name"
#define APPRECORD_PRICE_ENTRY               @"im:price"
#define APPRECORD_IMAGE_ENTRY               @"im:image"
#define APPRECORD_IMAGE_HEIGHT_ATTR         @"height"
#define APPRECORD_PREVIEW_ENTRY             @"link"
#define APPRECORD_PREVIEW_IMG_TITLE         @"title"
#define APPRECORD_PREVIEW_IMG_TYPE          @"type"
#define APPRECORD_PREVIEW_IMG_TYPE_PREFIX   @"image"
#define APPRECORD_PREVIEW_IMG_ATTR          @"href"

//分析
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    _bDataReceivedOpen = NO;
    if ([elementName isEqualToString:APPRECORD_ENTRY]) {
        _appRecord = [[QCGameAppRecord alloc] init];
        return;
    }
    
    if ([elementName isEqualToString:APPRECORD_NAME_ENTRY] ||
        [elementName isEqualToString:APPRECORD_PRICE_ENTRY]) {
        _bDataReceivedOpen = YES;
        
    }
    else if ([elementName isEqualToString:APPRECORD_IMAGE_ENTRY])
    {
        NSString *strTmp = nil;
        if (attributeDict) {
            strTmp = [attributeDict objectForKey:APPRECORD_IMAGE_HEIGHT_ATTR];
        }
        
        if (strTmp && [strTmp isEqualToString:@"100"]) {
            _bDataReceivedOpen = YES;
        }
        
    }
    else if([elementName isEqualToString:APPRECORD_PREVIEW_ENTRY]){
        NSString *strTmp = nil;
        if (attributeDict)
        {
            strTmp = [attributeDict objectForKey:APPRECORD_PREVIEW_IMG_TYPE];
            if (strTmp && [strTmp hasPrefix:APPRECORD_PREVIEW_IMG_TYPE_PREFIX]) {
                strTmp = [attributeDict objectForKey:APPRECORD_PREVIEW_IMG_ATTR];
                if (strTmp && _appRecord) {
                    _appRecord.largeImageURLString = strTmp;
                }
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_bDataReceivedOpen) {
        [_strDataReceived appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:APPRECORD_ENTRY]) {
        if (_appRecord) {
            [_arrGameAppRecords addObject:_appRecord];
            SAFE_RELEASE(_appRecord);
        }
        
        return;
    }
    
    NSString *strContent = nil;
    if (_appRecord && _bDataReceivedOpen) {
        if (_strDataReceived && _strDataReceived.length > 0) {
            strContent = [NSString stringWithString:_strDataReceived];
            [_strDataReceived setString:@""];
        }
        
        if ([elementName isEqualToString:APPRECORD_NAME_ENTRY]) {
            _appRecord.name = strContent;
        }
        else if([elementName isEqualToString:APPRECORD_PRICE_ENTRY]){
            _appRecord.price = strContent;
        }
        else if([elementName isEqualToString:APPRECORD_IMAGE_ENTRY]){
            if (strContent) {
                _appRecord.thumbImageURLString = strContent;
            }
        }
        
        _bDataReceivedOpen = NO;
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if (self.errorHandler) {
        self.errorHandler(parseError);
    }
}
@end
