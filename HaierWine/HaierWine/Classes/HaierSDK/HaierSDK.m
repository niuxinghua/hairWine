//
//  HaierSDK.m
//  HaierWine
//
//  Created by leon on 14-6-24.
//
//

#import "HaierSDK.h"

@implementation HaierSDK

/*启动uSDK
 
 **返回注册uSDK返回信息
 
*/
+ (uSDKErrorConst)registerHaierSDK
{
    uSDKManager *manager = [uSDKManager getSingleInstance];
    uSDKErrorConst error = [manager startSDK];

    while (error != RET_USDK_OK) {
        error = [manager startSDK];
    }
    
    return error;
}
+ (uSDKErrorConst)stopHaierSDK
{
    uSDKManager *manager = [uSDKManager getSingleInstance];
    uSDKErrorConst error = [manager stopSDK];
    
    while (error != RET_USDK_OK) {
        error = [manager stopSDK];
    }
    return error;
}
/**
 *	@brief	初始化日志
 *
 *	@param 	level 	日志级别
 *	@param 	isWriteToFile 	是否需要写文件
 *
 *	@return	返回设置日志结果
 */
+ (uSDKErrorConst)initHaierLog
{
    uSDKErrorConst error=[[uSDKManager getSingleInstance] initLog:USDK_LOG_NONE withWriteToFile:NO];
    return error;
}


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
+ (uSDKErrorConst)remoteUserLoginWithDevices:(NSArray *)devices andDevice:(uSDKDevice *)device
{
    return [[uSDKDeviceManager getSingleInstance] remoteUserLogin:device.mac withRemoteDevices:devices withAccessGatewayDomain:device.ip withAccessGatewayPort:0];
}

/**
 *	@brief	3.创建新的家电设备实例
 *
 *	@param 	deviceMac 	家电设备Mac地址
 *	@param 	deviceTypeIdentifier 	家电设备Identifier标识码
 *	@param 	online 	家电设备在线状态
 *	@param 	smartLinkVersion 	wifi版本
 *  @param 	smartLinkPlatform 	区分水净化系统及老空调系列模块
 *
 *	@return	如果deviceMac已存在则直接返回家电设备实例，否则创建后返回该家电设备实例
 */
+ (uSDKDevice*)getRemoteDeviceInstance:(NSString*)deviceMac withDeviceTypeIdentifier:(NSString*)deviceTypeIdentifier withOnline:(uSDKDeviceStatusConst)online withSmartLinkVersion:(NSString*)smartLinkVersion withSmartLinkPlatform:(NSString*)smartLinkPlatform
{
    return [uSDKDevice newRemoteDeviceInstance:deviceMac withDeviceTypeIdentifier:deviceTypeIdentifier withOnline:online withSmartLinkVersion:smartLinkVersion withSmartLinkPlatform:smartLinkPlatform];
}

/**
 *	@brief	远程用户登出
 *
 *	@return	返回执行结果信息
 */
+ (uSDKErrorConst)remoteUserLogout
{
    return [[uSDKDeviceManager getSingleInstance] remoteUserLogout];
}

/**
 *	@brief	订阅家电设备相关信息通知 <br>
 *          设备列表中的所有家电设备都可以订阅
 *
 *	@param 	object 	需要接收通知的对象实例
 *	@param 	aSelector 	接收到通知后执行的回调方法
 *	@param 	deviceMacList 	需要订阅的家电设备Mac地址列表
 */
+ (void)subscribeDevice:(id)object selector:(SEL)aSelector withMacList:(NSArray*)deviceMacList
{
    [[uSDKNotificationCenter defaultCenter] subscribeDevice:object selector:aSelector withMacList:deviceMacList];
}

/**
 *	@brief	执行操作方法
 *
 *	@param 	cmdList 	命令列表
 *	@param 	cmdsn 	命令sn
 *	@param 	groupCmdName 	组命令名称
 *
 *	@return	执行操作返回结果
 */
+ (uSDKErrorConst)execDeviceOperation:(NSMutableArray*)cmdList withCmdSN:(int)cmdsn withGroupCmdName:(NSString*)groupCmdName formDevice:(uSDKDevice *)device
{
    return [device execDeviceOperation:cmdList withCmdSN:cmdsn withGroupCmdName:groupCmdName];
}


/**
 *	@brief	发送配置设备信息方法
 *
 *	@param 	deviceConfigMode 	家电设备配置模式
 *	@param 	waitingConfirm 	是否需要等待确认
 *	@param 	deviceConfigInfo 	家电设备配置信息
 *
 *	@return	返回配置结果信息
 */
+ (uSDKErrorConst)setDeviceConfigInfoSSID:(NSString *)ssid andPassword:(NSString *)password
{
    uSDKDeviceConfigInfo *deviceInfo = [[uSDKDeviceConfigInfo alloc]init];
    deviceInfo.apSsid = ssid;
    deviceInfo.apPassword = password;
    uSDKErrorConst err = [[uSDKDeviceManager getSingleInstance] setDeviceConfigInfo:CONFIG_MODE_SMARTCONFIG watitingConfirm:NO deviceConfigInfo:deviceInfo];
    
    return err;
}



@end
