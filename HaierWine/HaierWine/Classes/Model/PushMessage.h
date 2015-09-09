//
//  PushMessage.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-19.
//
//

#import "ITTBaseModelObject.h"

@interface PushMessage : ITTBaseModelObject

@property (nonatomic,strong)NSString *type;
//0 高温消息 1推送消息 2高温已读消息 3推送已读
@property (nonatomic,strong)NSString *messageTitle;
@property (nonatomic,strong)NSString *messageType;
@property (nonatomic,strong)NSString *messageContent;
@property (nonatomic,strong)NSString *messageTime;
@property (nonatomic,assign)BOOL     isChecked;


@end
