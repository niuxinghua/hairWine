//
//  wineDevice.h
//  HaierWine
//
//  Created by leon on 14-7-31.
//
//

#import "ITTBaseModelObject.h"

@interface WineDevice : ITTBaseModelObject

@property (nonatomic ,strong) NSString *lamp;
@property (nonatomic ,strong) NSString *temperature;
@property (nonatomic ,strong) NSString *eProtocolVer;
@property (nonatomic ,strong) NSString *deviceMac;
@property (nonatomic ,strong) NSString *deviceLocation;
@property (nonatomic ,strong) NSString *deviceName;
@property (nonatomic ,strong) NSString *deviceStatus;
@property (nonatomic ,strong) NSString *typeIdentifier;
@property (nonatomic ,strong) NSString *deviceType;
@property (nonatomic ,strong) NSString *smartLinkPlatform;
@property (nonatomic ,strong) NSString *smartLinkSoftwareVersion;


@end
