// ################################################################################//
//		文件名 : AppDelegate.m
// ################################################################################//
/*!
 @file		AppDelegate.m
 @brief		应用代理类实现文件
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/08/23     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import "AppDelegate.h"
#import <Security/Security.h>

#define CFReleaseToNULL(a)  \
do {  if (a != NULL) { CFRelease(a); a = NULL; }					\
} while(false)

@interface AppDelegate(Private)
- (OSStatus)savePassword;
- (NSMutableArray*)getKeychainItem:(NSString*)strKeyChainLabel;
@end

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc {
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

#pragma mark -
#pragma mark Action
- (IBAction)actSavePassword:(id)sender
{
    [self savePassword];
}

- (IBAction)actGetPassword:(id)sender
{
    [self getPassword];
}

#pragma mark -
#pragma mark Utility
- (OSStatus)savePassword
{
    //值均为假定，可修改或者以参数传入
    NSString                    *strPassword            =   @"123456";
    NSString                    *strAccount             =   @"myTestAccount";
    NSString                    *strLabel               =   @"myTestLabel";
    NSString                    *strKeychainName        =   @"myTestKeychain";
    NSString					*strKeyChainDesc		=	@"test save password";
    
	OSStatus					err						=	noErr;
	SecAccessRef				access					=	NULL;
    CFMutableArrayRef			arrayTrustedApp			=	CFArrayCreateMutable(NULL, 0, NULL);
	SecKeychainItemRef			item					=	NULL;
	SecTrustedApplicationRef	TrustedAppSelf			=	NULL;
	SecTrustedApplicationRef	TrustedAppOther			=	NULL;
    NSArray						*arrKeychainExist		=	nil;
    
	SecKeychainAttribute		attrs[]					= 
	{
		{ kSecLabelItemAttr, (UInt32)[strLabel length], (char *)[strLabel UTF8String] },
		{ kSecAccountItemAttr, (UInt32)[strAccount length], (char *)[strAccount UTF8String] },
		{ kSecDescriptionItemAttr, 
			(UInt32)[strKeyChainDesc lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
            (char *)[strKeyChainDesc UTF8String] },
	};
    //作为SecKeychainItemCreateFromContent函数的第二个参数
    //包含的是钥匙串项目的具体属性信息
	SecKeychainAttributeList	attributes				= 
	{ sizeof(attrs) / sizeof(SecKeychainAttribute), attrs };
	
	//set trusted applications
	//第一个参数不设值，表示自己
	err = SecTrustedApplicationCreateFromPath(NULL, &TrustedAppSelf);
	if (err != noErr) {
		NSLog(@"error code = [%d].",err);
		goto err_handler;
	}
	CFArrayAppendValue(arrayTrustedApp,TrustedAppSelf);
    
	//set trusted applications
	//textEdit程序
	err = SecTrustedApplicationCreateFromPath([@"/Applications/TextEdit.app" UTF8String], &TrustedAppOther);
	if (err != noErr) {
		NSLog(@"error code = [%d].",err);
		goto err_handler;
	}
	CFArrayAppendValue(arrayTrustedApp,TrustedAppOther);
	
    //作为SecKeychainItemCreateFromContent函数的第六个参数
	//包含的是信任的程序列表，一般受保护性质的钥匙串项目都需要此要素。
	err = SecAccessCreate((CFStringRef)strKeychainName,
                          (CFArrayRef)arrayTrustedApp,
                          &access);
	if (err != noErr) {
		NSLog(@"error code = [%d].",err);
		goto err_handler;
	}
    
	//get existing keychain
	arrKeychainExist = [self getKeychainItem:strLabel];
	if(arrKeychainExist != nil && [arrKeychainExist count] > 0)
	{
		err = SecKeychainItemModifyContent((SecKeychainItemRef)[arrKeychainExist objectAtIndex:0],
                                           &attributes,
                                           (UInt32)[strPassword length],
                                           [strPassword UTF8String]);
	}
	else
	{
        //创建新项目
        err = SecKeychainItemCreateFromContent( kSecGenericPasswordItemClass,   //普通密码
                                               &attributes,                    //项目属性信息
                                               (UInt32)[strPassword length],   //项目值的长度
                                               [strPassword UTF8String],       //项目值的信息
                                               NULL,                           //保存至哪个钥匙串集，NULL表示默认钥匙串集
                                               access,                         //信任列表
                                               NULL);                          //当场返回新创建的钥匙串项目，这里对我们来说不需要	
	}
	if (err != noErr) {
		NSLog(@"error code = [%d].",err);
		goto err_handler;
	}
    
err_handler:
	CFReleaseToNULL(access);
	CFReleaseToNULL(item);
	CFReleaseToNULL(TrustedAppSelf);
	CFReleaseToNULL(TrustedAppOther);
	CFReleaseToNULL(arrayTrustedApp);
    
	return err;
}


- (OSStatus)getPassword
{
    //值均为假定，可修改或者以参数传入
    NSString                *strOutPassword         =   nil;
    NSString                *strLabel               =   @"myTestLabel";
    
	OSStatus				err				=	noErr;
	UInt32					nPswdLength		=	0;
	char*					cPswd			=	NULL;
	NSArray					*arrKeychain	=	nil;
	SecKeychainItemRef		itemRef			=	NULL;
    SecItemClass            class           =   0;
    
	//
	//读取所有符合查询条件的钥匙串项目
	arrKeychain = [self getKeychainItem:strLabel];
	if (arrKeychain == nil || [arrKeychain count] == 0) {
        NSLog(@"error code = [%d].",readErr);
		return readErr;
	}
	
	itemRef = (SecKeychainItemRef)[arrKeychain objectAtIndex:0];
    //读取value（值）
	err = SecKeychainItemCopyContent(itemRef,           //钥匙串项目
                                     &class,            //钥匙串类型
                                     NULL,              //其他内容，这里我们不关心，所以NULL
                                     &nPswdLength,      //取得value的长度
                                     (void**)&cPswd);   //取得value的内容
	if (err != noErr)	{
		NSLog(@"error code = [%d].",err);
        goto error_handler;		
	}
	
	strOutPassword = (NSString*)CFStringCreateWithBytes(NULL, 
                                                        (UInt8*)cPswd, 
                                                        nPswdLength, 
                                                        kCFStringEncodingUTF8, 
                                                        FALSE);
    if(strOutPassword == nil)
	{
		err = memFullErr;
		NSLog(@"error code = [%d].",err);
		goto error_handler;		
	}
	
error_handler:
    SecKeychainItemFreeContent(NULL,cPswd);
    CFReleaseToNULL(strOutPassword);
	return err;
}

 
- (NSMutableArray*)getKeychainItem:(NSString*)strKeyChainLabel
{
	OSStatus					status				= noErr;
	SecKeychainItemRef			item				= NULL;
	SecKeychainSearchRef		searchRef			= NULL;
	SecKeychainAttribute        attrsSearch[]       = {
        { kSecLabelItemAttr, (UInt32)[strKeyChainLabel length], (char *)[strKeyChainLabel UTF8String] }
    };
    SecKeychainAttributeList	list;
	NSMutableArray*				arrKeyChain			= [NSMutableArray arrayWithCapacity:0];
	
	//项目属性
	list.count = 1;
	list.attr = attrsSearch;
	
	//查询条件生成
	status = SecKeychainSearchCreateFromAttributes(NULL,                            //一个钥匙串集或一个钥匙串集数组，NULL代表在默认钥匙串集中查找
                                                   kSecGenericPasswordItemClass,    //普通密码
												   &list,                           //项目属性信息
                                                   &searchRef);
	if (status != noErr)
	{
		NSLog(@"error code = [%d].",status);
		goto err_handler;		
	}
	
	//迭代地去找匹配的钥匙串项目
	while (SecKeychainSearchCopyNext (searchRef, &item) == noErr) {	
		[arrKeyChain addObject:(id)item];
		CFReleaseToNULL(item);
	}
	
err_handler:
	if (searchRef != nil)
	{
		CFRelease(searchRef);
		searchRef = nil;
	}
    
	CFReleaseToNULL(item);
	
	return arrKeyChain;	
}

@end
