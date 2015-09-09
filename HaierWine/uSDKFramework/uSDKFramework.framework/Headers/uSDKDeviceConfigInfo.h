//
//  uSDKDeviceConfigInfo.h
//  uSDK_iOS_v2
//
//  Created by Zono on 14-1-7.
//  Copyright (c) 2014年 haierubic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uSDKConstantInfo.h"
/**
 *	@brief	家电设备配置信息类
 */
@interface uSDKDeviceConfigInfo : NSObject

/**
 *	@brief	家电设备类别
 */
@property (nonatomic, assign) uSDKDeviceTypeConst type;

/**
 *	@brief	家电设备mac
 */
@property (nonatomic, strong) NSString* mac;

/**
 *	@brief	家电设备ip
 */
@property (nonatomic, strong) NSString* ip;

/**
 *	@brief	家电设备搜索到的wifi列表
 */
@property (nonatomic, strong) NSMutableArray* aplist;

/**
 *	@brief	配置需要连接的SSID
 */
@property (nonatomic, strong) NSString* apSsid;

/**
 *	@brief	配置需要连接SSID对应的密码
 */
@property (nonatomic, strong) NSString* apPassword;

/**
 *	@brief	家电设备E++协议版本
 */
@property (nonatomic, strong) NSString* eProtocolVer;

/**
 *	@brief	家电设备所在房间名称
 */
@property (nonatomic, strong) NSString* roomname;

/**
 *	@brief	配置家电设备所连接的控制服务器域名/IP
 */
@property (nonatomic, strong) NSString* accessGatewayDomain;

/**
 *	@brief	配置家电设备所连接的控制服务器端口
 */
@property (nonatomic, assign) NSInteger accessGatewayPort;

/**
 *	@brief	配置家电设备所连接的备用控制服务器域名/IP
 */
@property (nonatomic, strong) NSString* accessGatewayDomainBackup;

/**
 *	@brief	配置家电设备所连接的备用控制服务器端口
 */
@property (nonatomic, assign) NSInteger accessGatewayPortBackup;

/**
 *	@brief	家电设备Identifier标识码
 */
@property (nonatomic, strong) NSString* typeIdentifier;

/**
 *	@brief	【准备废弃】连接家电设备使用的密码
 */
@property (nonatomic, strong) NSString* devicePassword;

/**
 *	@brief	是否使用DHCP
 */
@property (nonatomic, assign) BOOL isDHCP;

/**
 *	@brief	子网掩码地址
 */
@property (nonatomic, strong) NSString* mask;

/**
 *	@brief	网关地址
 */
@property (nonatomic, strong) NSString* gateway;

/**
 *	@brief	DNS地址
 */
@property (nonatomic, strong) NSString* dns;

@end



/**
 *	@brief	wifi热点信息
 */
@interface uSDKDeviceConfigInfoAp : NSObject

/**
 *	@brief	wifi热点的SSID
 */
@property (nonatomic, strong) NSString* ssid;

/**
 *	@brief	wifi热点的信号强度
 */
@property (nonatomic, assign) int power;

/**
 *	@brief	wifi加密方式
 */
@property (nonatomic, assign) uSDKApEncryptionTypeConst encrytionType;


@end
