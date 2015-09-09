//
//  uSDKManager.h
//  uSDK_iOS_v2
//
//  Created by Zono on 14-1-7.
//  Copyright (c) 2014年 haierubic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uSDKConstantInfo.h"

/**
 *	@brief	uSDK管理类（单例）
 */
@interface uSDKManager : NSObject

/**
 *	@brief	日志级别
 */
@property (nonatomic, assign) uSDKLogLevelConst logLevel;

/**
 *	@brief	错误码中文对应字典
 */
@property (nonatomic, strong) NSDictionary* constantInfoDic;
/**
 *	@brief	uSDK版本
 */
@property (nonatomic, strong) NSString* uSDKVersion;

/**
 *	@brief	获取uSDKManager单例
 *
 *	@return	返回uSDKManager单例
 */
+ (uSDKManager*)getSingleInstance;

/**
 *	@brief	初始化日志
 *
 *	@param 	level 	日志级别
 *	@param 	isWriteToFile 	是否需要写文件
 *
 *	@return	返回设置日志结果
 */
- (uSDKErrorConst)initLog:(uSDKLogLevelConst)level withWriteToFile:(BOOL)isWriteToFile;

/**
 *	@brief	启动uSDK
 *
 *	@return	返回启动uSDK结果
 */
- (uSDKErrorConst)startSDK;

/**
 *	@brief	停止uSDK
 *
 *	@return	返回停止uSDK结果
 */
- (uSDKErrorConst)stopSDK;

@end



