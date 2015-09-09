//
//  uSDKDevice.h
//  uSDK_iOS_v2
//
//  Created by Zono on 14-1-7.
//  Copyright (c) 2014年 haierubic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uSDKConstantInfo.h"
#import "uSDKBusinessMessage.h"

/**
 *	@brief	家电设备类
 */
@interface uSDKDevice : NSObject

/**
 *	@brief	家电设备mac
 */
@property (nonatomic, strong) NSString* mac;

/**
 *	@brief	家电设备IP
 */
@property (nonatomic, strong) NSString* ip;

/**
 *	@brief	家电设备E++协议版本
 */
@property (nonatomic, strong) NSString* eProtocolVer;

/**
 *	@brief	smartLink硬件平台
 */
@property (nonatomic, strong) NSString* smartLinkPlatform;

/**
 *	@brief	smartLink软件版本号
 */
@property (nonatomic, strong) NSString* smartLinkSoftwareVersion;

/**
 *	@brief	smartLink硬件版本号
 */
@property (nonatomic, strong) NSString* smartLinkHardwareVersion;

/**
 *	@brief	配置文件版本号
 */
@property (nonatomic, strong) NSString* smartLinkDevfileVersion;

/**
 *	@brief	家电设备Identifier标识码
 */
@property (nonatomic, strong) NSString* typeIdentifier;

/**
 *	@brief	家电设备网络类型（远程/本地）
 */
@property (nonatomic, assign) uSDKDeviceNetTypeConst netType;

/**
 *	@brief	家电设备当前状态（在线/离线/就绪/不可用）
 */
@property (nonatomic, assign) uSDKDeviceStatusConst status;

/**
 *	@brief	家电设备类型
 */
@property (nonatomic, assign) uSDKDeviceTypeConst type;

/**
 *	@brief	家电设备属性字典
 */
@property (nonatomic, strong) NSMutableDictionary* attributeDict;

/**
 *	@brief	家电设备报警列表
 */
@property (nonatomic, strong) NSMutableArray* alarmList;

/**
 *	@brief	家电设备透传信息（红外数据/生产检测数据/大数据）
 */
@property (nonatomic, strong) uSDKTransparentMessage* checkingResultMessage;

/**
 *	@brief	家电设备是否已订阅
 */
@property (nonatomic, assign) BOOL isSubscribed;

/**
 *	@brief	创建新的家电设备实例
 *
 *	@param 	deviceMac 	家电设备Mac地址
 *	@param 	deviceTypeIdentifier 	家电设备Identifier标识码
 *	@param 	online 	家电设备在线状态
 *	@param 	smartLinkVersion 	wifi版本
 *  @param 	smartLinkPlatform 	区分水净化系统及老空调系列模块
 *
 *	@return	如果deviceMac已存在则直接返回家电设备实例，否则创建后返回该家电设备实例
 */
+ (uSDKDevice*)newRemoteDeviceInstance:(NSString*)deviceMac withDeviceTypeIdentifier:(NSString*)deviceTypeIdentifier withOnline:(uSDKDeviceStatusConst)online withSmartLinkVersion:(NSString*)smartLinkVersion withSmartLinkPlatform:(NSString*)smartLinkPlatform;

/**
 *	@brief	执行操作方法
 *
 *	@param 	cmdList 	命令列表
 *	@param 	cmdsn 	命令sn
 *	@param 	groupCmdName 	组命令名称
 *
 *	@return	执行操作返回结果
 */
- (uSDKErrorConst)execDeviceOperation:(NSMutableArray*)cmdList withCmdSN:(int)cmdsn withGroupCmdName:(NSString*)groupCmdName;

@end


/**
 *	@brief	复杂类设备属性类
 */
@interface uSDKComplexDevice : uSDKDevice

/**
 *	@brief	复杂类设备子机号
 */
@property (nonatomic, assign) NSString* subId;

@end


/**
 *	@brief	家电设备属性类
 */
@interface uSDKDeviceAttribute : NSObject

/**
 *	@brief	家电设备属性名
 */
@property (nonatomic, strong) NSString* attrName;

/**
 *	@brief	家电设备属性值
 */
@property (nonatomic, strong) NSString* attrValue;

/**
 *	@brief	创建并初始化家电设备属性实例
 *
 *	@param 	attrName 	家电设备属性名
 *	@param 	attrValue 	家电设备属性值
 *
 *	@return	返回家电设备属性实例
 */
- (id)initWithAttrName:(NSString*)attrName withAttrValue:(NSString*)attrValue;

@end


/**
 *	@brief	报警信息类
 */
@interface uSDKDeviceAlarm : NSObject

/**
 *	@brief	报警信息
 */
@property (nonatomic, strong) NSString* alarmMessage;

/**
 *	@brief	报警时间
 */
@property (nonatomic, strong) NSString* alarmTimestamp;

@end
