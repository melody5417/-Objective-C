// ################################################################################//
//		文件名 : QCParserOperation.h
// ################################################################################//
/*!
 @file		QCParserOperation.h
 @brief		XML分析工具类
 @author	Copyright (C) MaAYa.Qian 2013
 
 @date  修改日期        修改者        注释
 @date  2012/10/24     MaAYa        文件内容初始化
 */
// ##########< INCLUDE FILES >#####################################################*
#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSArray *);
typedef void (^ErrorBlock)(NSError *);

@interface QCParserOperation : NSOperation {
}

//XML解析任务初始化接口
- (id)initWithURL:(NSURL *)url
completionHandler:(SuccessBlock)successBlock
        errHander:(ErrorBlock)errBlock;

@end
