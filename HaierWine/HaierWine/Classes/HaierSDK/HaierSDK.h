//
//  HaierSDK.h
//  HaierWine
//
//  Created by 李洋 on 14-6-24.
//
//
//  1.每次启动程序都需要注册也就是开启uSDK，使用方法.
//  2.开启日志log信息
//  3.远程用户登录，从haier云端服务器拉取可控设备列表.
//

#import <Foundation/Foundation.h>
#import <uSDKFramework/uSDKDeviceManager.h>
#import <uSDKFramework/uSDKManager.h>
#import <uSDKFramework/uSDKDevice.h>
#import <uSDKFramework/uSDKNotificationCenter.h>

@protocol HaierSDKDelegate <NSObject>

- (void)didReceiveDeviceListChanged;

@end

@interface HaierSDK : NSObject

@property (nonatomic ,assign) id<HaierSDKDelegate>delegate;

/*1.启动uSDK
 
 *返回注册uSDK返回信息
 
 */
+ (uSDKErrorConst)registerHaierSDK;
+ (uSDKErrorConst)stopHaierSDK;
/**
 *	@brief	2.初始化日志
 *
 *	@param 	level 	日志级别
 *	@param 	isWriteToFile 	是否需要写文件
 *
 *	@return	返回设置日志结果
 */
+ (uSDKErrorConst)initHaierLog;

/**
 *	@brief	3.远程用户登录
 *
 *	@param 	session 	从认证服务器获取到的session
 *	@param 	remoteDevices 	从业务服务器获取到的设备列表
 *	@param 	domain 	接入网关域名/IP
 *	@param 	port 	接入网关端口
 *
 *	@return	返回执行结果信息
 */
+ (uSDKErrorConst)remoteUserLoginWithDevices:(NSArray *)devices andDevice:(uSDKDevice *)device;

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
+ (uSDKDevice*)getRemoteDeviceInstance:(NSString*)deviceMac withDeviceTypeIdentifier:(NSString*)deviceTypeIdentifier withOnline:(uSDKDeviceStatusConst)online withSmartLinkVersion:(NSString*)smartLinkVersion withSmartLinkPlatform:(NSString*)smartLinkPlatform;

/**
 *	@brief	远程用户登出
 *
 *	@return	返回执行结果信息
 */
+ (uSDKErrorConst)remoteUserLogout;

/**
 *	@brief	订阅家电设备相关信息通知 <br>
 *          设备列表中的所有家电设备都可以订阅
 *
 *	@param 	object 	需要接收通知的对象实例
 *	@param 	aSelector 	接收到通知后执行的回调方法
 *	@param 	deviceMacList 	需要订阅的家电设备Mac地址列表
 */
+ (void)subscribeDevice:(id)object selector:(SEL)aSelector withMacList:(NSArray*)deviceMacList;

/**
 *	@brief	执行操作方法
 *
 *	@param 	cmdList 	命令列表
 *	@param 	cmdsn 	命令sn
 *	@param 	groupCmdName 	组命令名称
 *
 *	@return	执行操作返回结果
 */
+ (uSDKErrorConst)execDeviceOperation:(NSMutableArray*)cmdList withCmdSN:(int)cmdsn withGroupCmdName:(NSString*)groupCmdName;

/**
 *	@brief	发送配置设备信息方法
 *
 *	@param 	deviceConfigMode 	家电设备配置模式
 *	@param 	waitingConfirm 	是否需要等待确认
 *	@param 	deviceConfigInfo 	家电设备配置信息
 *
 *	@return	返回配置结果信息
 */
+ (uSDKErrorConst)setDeviceConfigInfoSSID:(NSString *)ssid andPassword:(NSString *)password;



@end
