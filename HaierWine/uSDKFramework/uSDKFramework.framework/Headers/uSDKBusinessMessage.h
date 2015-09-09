//
//  uSDKBusinessMessage.h
//  uSDK_iOS_v2
//
//  Created by Zono on 14-1-7.
//  Copyright (c) 2014年 haierubic. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	@brief	uSDK业务数据信息类
 */
@interface uSDKBusinessMessage : NSObject

/**
 *	@brief	业务数据命令字
 */
@property(nonatomic, assign) int command;

/**
 *	@brief	业务数据内容
 */
@property(nonatomic, strong) NSData* messageContent;

/**
 *	@brief	与该业务数据相关的家电设备的Mac地址，如果与家电设备无关则Mac地址未全0
 */
@property(nonatomic, strong) NSString* deviceMac;

@end


/**
 *	@brief	uSDK透传消息类
 */
@interface uSDKTransparentMessage : NSObject

/**
 *	@brief	透传消息类型（红外数据/生产检测数据/大数据）
 */
@property(nonatomic, assign) uSDKMessageTypeConst messageType;

/**
 *	@brief	透传消息内容
 */
@property(nonatomic, strong) NSString* messageContent;

/**
 *	@brief	与该透传消息数据相关的家电设备的Mac地址
 */
@property(nonatomic, strong) NSString* deviceMac;

@end
