//
//  AppVersionModel.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-20.
//
//

#import "ITTBaseModelObject.h"

@interface AppVersionModel : ITTBaseModelObject

@property (strong, nonatomic) NSString * verion;            //版本号
@property (strong, nonatomic) NSString * verionName;        //版本名
@property (strong, nonatomic) NSString * description;       //描述
@property (strong, nonatomic) NSString * resId;             //资源id
@property (assign, nonatomic) int         status;           //状态
@property (assign, nonatomic) BOOL        force;            //是否强制


@end
