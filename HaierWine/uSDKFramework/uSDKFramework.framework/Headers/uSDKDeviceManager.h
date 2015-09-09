//
//  uSDKDeviceManager.h
//  uSDK_iOS_v2
//
//  Created by Zono on 14-1-7.
//  Copyright (c) 2014年 haierubic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uSDKConstantInfo.h"
#import "uSDKDeviceConfigInfo.h"

/**
 *	@brief	设备管理类（单例）
 */
@interface uSDKDeviceManager : NSObject

/**
 *	@brief	设备列表字典，存储形式：[{Key: 家电设备mac1, Object: 家电设备实例1}, {}...]
 */
@property (nonatomic, strong) NSMutableDictionary* deviceDict;

/**
 *	@brief	复杂类设备列表字典，存储形式：[{Key: 家电设备mac1, Object: 复杂类家电设备列表1}, {}...]
 *  @brief  注：复杂类家电设备列表中的元素为 uSDKComplexDevice 复杂类设备实例。
 */
@property (nonatomic, strong) NSMutableDictionary* subDeviceDict;

/**
 *	@brief	获取uSDKDeviceManager单例方法
 *
 *	@return	返回uSDKDeviceManager单例
 */
+ (uSDKDeviceManager*)getSingleInstance;

/**
 *	@brief	根据设备类型获取数组形式的家电设备列表
 *
 *	@return	数组形式的家电设备列表，存储形式：{设备实例1, 设备实例2, ...}
 */
- (NSArray*)getDeviceList:(uSDKDeviceTypeConst)deviceType;

/**
 *	@brief	【准备废弃，使用 [[uSDKDeviceManager getSingleInstance] getDeviceList:0] 来代替】获取数组形式的家电设备列表
 *
 *	@return	数组形式的家电设备列表，存储形式：{设备实例1, 设备实例2, ...}
 */
- (NSArray*)getDeviceList;

/**
 *	@brief	获取设备配置信息方法
 *
 *	@return	返回设备配置类实例
 */
- (uSDKDeviceConfigInfo*)getDeviceConfigInfo;

/**
 *	@brief	发送配置设备信息方法
 *
 *	@param 	deviceConfigMode 	家电设备配置模式
 *	@param 	waitingConfirm 	是否需要等待确认
 *	@param 	deviceConfigInfo 	家电设备配置信息
 *
 *	@return	返回配置结果信息
 */
- (uSDKErrorConst)setDeviceConfigInfo:(uSDKDeviceConfigModeConst)deviceConfigMode watitingConfirm:(BOOL)waitingConfirm deviceConfigInfo:(uSDKDeviceConfigInfo*)deviceConfigInfo;

/**
 *	@brief	远程用户登录
 *
 *	@param 	session 	从认证服务器获取到的session
 *	@param 	remoteDevices 	从业务服务器获取到的设备列表
 *	@param 	domain 	接入网关域名/IP
 *	@param 	port 	接入网关端口
 *
 *	@return	返回执行结果信息
 */
- (uSDKErrorConst)remoteUserLogin:(NSString*)session withRemoteDevices:(NSArray*)remoteDevices withAccessGatewayDomain:(NSString*)domain withAccessGatewayPort:(NSInteger)port;


/**
 *	@brief	远程用户登出
 *
 *	@return	返回执行结果信息
 */
- (uSDKErrorConst)remoteUserLogout;


@end
