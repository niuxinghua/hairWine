//
//  uSDKNotificationCenter.h
//  uSDK_iOS_v2
//
//  Created by oet on 14-1-13.
//  Copyright (c) 2014年 haierubic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uSDKConstantInfo.h"

/**
 *	@brief	uSDK通知中心类
 */
@interface uSDKNotificationCenter : NSObject

/**
 *	@brief	消息字典集合，[{Key: 消息类型, Object: 对应通知数据}, {}...] <b r>
 *    消息类型及对应的数据：<br>
 *    deviceListChangedNotify --- 发生变化的设备列表 <br>
 *    deviceOnlineChangedNotify --- 发生变化的设备Mac：此设备的在线状态，uSDKDeviceStatusConst类型 <br>
 *    deviceStatusChangedNotify --- 发生变化的设备Mac：此设备当前发生的属性变化字典 <br>
 *    deviceAlarmNotify --- 发生变化的设备Mac：此设备当前上报的报警列表 <br>
 *    deviceInfraredInfoNotify --- 当前上报的红外消息，uSDKTransparentMessage类实例 <br>
 *    bigDataNotify --- 当前上报的大数据消息，uSDKTransparentMessage类实例 <br>
 *    deviceBindMessageNotify --- 设备Mac：解绑或绑定 <br>
 *    businessMessageNofify --- 当前推送的业务消息，uSDKBusinessMessage类实例 <br>
 *    sessionExceptionNotify --- 当前失效的远程session，字符串类型
 */
//@property(nonatomic, strong) NSMutableDictionary *messageDictionary;

/**
 *	@brief	获取uSDKNotificationCenter单例
 *
 *	@return	返回uSDKNotificationCenter单例
 */
+ (uSDKNotificationCenter*)defaultCenter;

/**
 *	@brief	订阅家电设备相关信息通知 <br>
 *          设备列表中的所有家电设备都可以订阅
 *
 *	@param 	object 	需要接收通知的对象实例
 *	@param 	aSelector 	接收到通知后执行的回调方法
 *	@param 	deviceMacList 	需要订阅的家电设备Mac地址列表
 */
- (void)subscribeDevice:(id)object selector:(SEL)aSelector withMacList:(NSArray*)deviceMacList;

/**
 *	@brief	订阅家电设备列表变化通知
 *
 *	@param 	object 	需要接收通知的对象实例
 *	@param 	selector 	接收到通知后执行的回调方法
 *  @param  deviceType  需要订阅变化通知的设别类型
 */
- (void)subscribeDeviceListChanged:(id)object selector:(SEL)selector withDeviceType:(uSDKDeviceTypeConst)deviceType;

/**
 *	@brief	订阅业务数据上报通知
 *
 *	@param 	object 	需要接收通知的对象实例
 *	@param 	selector 	接收到通知后执行的回调方法
 */
- (void)subscribeBusinessMessage:(id)object selector:(SEL)selector;

/**
 *	@brief	取消家电设备相关信息通知
 *
 *	@param 	object 	取消接收通知的对象实例
 *	@param 	deviceMacList 	取消订阅的家电设备Mac地址列表
 */
- (void)unSubscribeDevice:(id)object withMacList:(NSArray*)deviceMacList;

/**
 *	@brief	取消订阅家电设备列表变化通知
 *
 *	@param 	object 	取消接收通知的对象实例
 */
- (void)unSubscribeDeviceListChanged:(id)object;

/**
 *	@brief	取消业务数据上报通知
 *
 *	@param 	object 	取消接收通知的对象实例
 */
- (void)unSubscribeBusinessMessage:(id)object;

@end
