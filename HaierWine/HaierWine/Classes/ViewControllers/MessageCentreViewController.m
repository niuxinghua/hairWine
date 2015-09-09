//
//  MessageCentreViewController.m
//  HaierWine
//
//  Created by david on 14/8/11.
//
//

#import "MessageCentreViewController.h"
#import "PKRevealController.h"
#import "AlertMessageDetailViewController.h"
#import "NewsMessageDetailViewController.h"
#import "PushMessage.h"
#import "DetailViewController.h"
#import "DetailWineViewController.h"

@interface MessageCentreViewController (){
    
    IBOutlet UIButton *_allSelectButton;
    IBOutlet UIView *_selectAllView;
    IBOutlet ITTPullTableView   *_tableView;
    NSMutableArray              *_dataArray;
    IBOutlet UIButton           *_leftBtn;
    IBOutlet UIButton           *_rightBtn;
    IBOutlet UILabel            *_cancleLabel;
    IBOutlet UIImageView        *_kindIconImageView;
    IBOutlet UIImageView        *_imageView;
    IBOutlet UILabel            *_label;
    
    BOOL                         _isEdit;
    BOOL                         _isAllSelected;
    NSMutableIndexSet           *_selectedIndexSet;
}

@end

@implementation MessageCentreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"RECEIVEPUSHMESSAGE"  object:nil];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 //   [_tableView reloadData];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    _isAllSelected = NO;
     _selectedIndexSet = [[NSMutableIndexSet alloc]init];
    if (DATA_ENV.pushMessageArray.count != 0) {
        _imageView.hidden = YES;
        _label.hidden = YES;
    } else {
        _rightBtn.hidden = YES;
    }
    _dataArray = [[NSMutableArray alloc]init];
    for (int i =0 ;i < DATA_ENV.pushMessageArray.count ;i++) {
        PushMessage *pushMessag = [DATA_ENV.pushMessageArray objectAtIndex:DATA_ENV.pushMessageArray.count - i-1];
        [_dataArray addObject:pushMessag];
    }
   // NSLog(@"$$$$$%@",DATA_ENV.pushMessageArray);
   // NSLog(@"&&&&&&%@",_dataArray);
   // [_dataArray removeAllObjects];
   // [_dataArray addObjectsFromArray: [[SavePushMassage shareSavePushMassage] getPushMessages]];
    _cancleLabel.hidden = YES;
    _kindIconImageView.hidden = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setLoadMoreViewHidden:YES];
    [_tableView setRefreshViewHidden:YES];
    if (_isDetail) {
        _isDetail = NO;
        if (_dataArray.count!=0) {
            PushMessage *pushMessag = (PushMessage * )_dataArray.firstObject;
            if ([pushMessag.type isEqualToString:@"0"]) {
                
                pushMessag.type = @"2";
                
            } else if ([pushMessag.type isEqualToString:@"1"]){
                
                pushMessag.type = @"3";
                
            }
            AlertMessageDetailViewController *alertVc = [[AlertMessageDetailViewController alloc]init];
            alertVc.alertContent = pushMessag.messageContent;
            [self.navigationController pushViewController:alertVc animated:YES];
        }

    }
    
    //9.19dd
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    


}

- (void)refreshTableView
{
    [_dataArray removeAllObjects];
    for (int i =0 ;i < DATA_ENV.pushMessageArray.count ;i++) {
        PushMessage *pushMessag = [DATA_ENV.pushMessageArray objectAtIndex:DATA_ENV.pushMessageArray.count - i-1];
        [_dataArray addObject:pushMessag];
    }
    _imageView.hidden = YES;
    _label.hidden = YES;
    [_tableView reloadData];

}

-(IBAction)backClick:(id)sender
{

    UIButton *btn = (UIButton *)sender;
    if (btn.isSelected == NO) {
        _kindIconImageView.hidden = NO;
        _cancleLabel.hidden = YES;
        
        //9.23
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i = 0; i<_dataArray.count; i++) {
            PushMessage *pushMessage = [_dataArray objectAtIndex:_dataArray.count -i-1];
            [array addObject:pushMessage];
        }
        DATA_ENV.pushMessageArray = array;
     //   NSLog(@"xxxxx%d",array.count);
        
        
//        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
        
        if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
        {
            [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
        }
        else
        {
            [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
        }
        
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        for (int i = 0; i<_dataArray.count; i++) {
//            PushMessage *pushMessage = [_dataArray objectAtIndex:_dataArray.count -i-1];
//            [array addObject:pushMessage];
//        }
//        DATA_ENV.pushMessageArray = array;
//        NSLog(@"xxxxx%d",array.count);
        
    } else {
        _kindIconImageView.hidden = NO;
        _cancleLabel.hidden = YES;
        [_rightBtn setSelected:NO];
        [btn setSelected:NO];
        _isEdit = NO;
        _isAllSelected = NO;
        _tableView.top = _tableView.top - 44;
        _selectAllView.hidden = YES;
        [_tableView reloadData];
    }
    
}
-(IBAction)editClick:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    if (btn.isSelected == NO) {
        
        [btn setSelected:YES];
        [_leftBtn setSelected:YES];
        _isEdit = YES;
        _cancleLabel.hidden = NO;
        _kindIconImageView.hidden = YES;
        _tableView.top = _tableView.top + 44;
        _selectAllView.hidden = NO;
        _isAllSelected = NO;
        [_tableView reloadData];
        
    } else {
        
    //删除功能
      //  NSLog(@"删除");
        
        if (_selectedIndexSet.count == 0) {
            /*
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"未选中任何记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            */
            DeleteAlertView *alert = [DeleteAlertView loadFromXib];
            alert.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            alert.type = DeleteAlertViewTypeMessage;
            alert.delegate = self;
            [self.view addSubview:alert];
            
        } else {
        /*
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        */
            DeleteAlertView *alert = [DeleteAlertView loadFromXib];
            alert.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            alert.type = DeleteAlertViewTypeAskSure;
            alert.delegate = self;
            [self.view addSubview:alert];
            
        }
        
    }
    
}
/*
#pragma mark - alertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    //取消
    } else {
    //删除
        [_dataArray removeObjectsAtIndexes:_selectedIndexSet];
        if (_dataArray.count == 0) {
            _imageView.hidden = NO;
            _label.hidden = NO;
            _rightBtn.hidden = YES;
        }
        
        //        NSMutableArray *array = [[NSMutableArray alloc]init];
        //        for (int i = 0; i<_dataArray.count; i++) {
        //            PushMessage *pushMessage = [_dataArray objectAtIndex:_dataArray.count -i-1];
        //            [array addObject:pushMessage];
        //        }
        //
        //        DATA_ENV.pushMessageArray = array;
        [_selectedIndexSet removeAllIndexes];
        [_tableView reloadData];
    }
}
*/
#pragma mark- delete alertView delegate
- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type{
    
    if (type == DeleteAlertViewTypeNoSelected) {
        
        
    } else if (type == DeleteAlertViewTypeAskSure){
    
        if (tag == 0) {
        //取消
        } else if (tag == 1){
        //删除
            [_dataArray removeObjectsAtIndexes:_selectedIndexSet];
            if (_dataArray.count == 0) {
                _imageView.hidden = NO;
                _label.hidden = NO;
                _rightBtn.hidden = YES;
            }
            [_selectedIndexSet removeAllIndexes];
            [self backClick:_leftBtn];
            _isAllSelected = NO;
        //    _tableView.top = _tableView.top - 44;
            _selectAllView.hidden = YES;
            [_tableView reloadData];
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (int i = 0; i<_dataArray.count; i++) {
                PushMessage *pushMessage = [_dataArray objectAtIndex:_dataArray.count -i-1];
                [array addObject:pushMessage];
            }
            DATA_ENV.pushMessageArray = array;

        }
    }
}
-(void)getCloudMessageRequest:(NSString *)messageId{
   // NSString *url = @"http://103.8.220.166:40000/commonapp/users/100013957366154898/originalMessages";
    LoadingView *loadingView = [LoadingView loadFromXib];
    loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];

    NSString *url = [NSString stringWithFormat:@"http://uhome.haier.net:6000/commonapp/users/%@/originalMessages",DATA_ENV.userid];

    NSDictionary *dic = @{@"appId": APPID,
                          @"type" :@"M",
                          @"messageIds" :messageId};//37680
    [getPushMessage requestWithParameters:dic
                           withRequestUrl:url withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                               [loadingView removeFromSuperview];
                               if (![request.handleredResult[@"retCode"] isEqualToString:@"00000"]) {
                                   return ;
                               }
                               // NSLog(@"message_type%@",request.handleredResult);
                               if(![request.handleredResult[@"retCode"] isEqualToString:@"00000"]){
                                   return ;
                               }
                               NSArray *dataArr = request.handleredResult[@"data"];
                               //      NSLog(@"dataArrdataArr%@",dataArr.firstObject);
                               if (dataArr.count==0) {
                                   return ;
                               }
                               NSDictionary *dataDic = dataArr.firstObject;
                               
                               //      NSLog(@"bodyDic %@",dataDic[@"body"][@"messageContent"][@"content"][@"type"]);
                               //typeid:3_value:20
                               NSString *messageType = dataDic[@"body"][@"messageContent"][@"content"][@"type"];
                               NSArray *messageTypeArr = [messageType componentsSeparatedByString:@"_"];
                               NSString *messageTypeIdStr = (NSString *)messageTypeArr.firstObject;
                               NSString *messageTypeValueStr = (NSString *)messageTypeArr.lastObject;
                               NSString *messageIdStr = [self analyseStr:messageTypeIdStr];
                               NSString *messageValueStr = [self analyseStr:messageTypeValueStr];
                               
                               // NSLog(@"messageIdStr %@ %@",messageIdStr,messageValueStr);
                               
                               switch (messageIdStr.integerValue) {
                                   case 3:
                                   {//新闻详情
                                       DetailViewController *detailVc = [[DetailViewController alloc]init];
                                       detailVc.newsId = messageValueStr;
                                       detailVc.type = NewsDetailType;
                                       [self.navigationController pushViewController:detailVc animated:YES];
                                   }
                                       break;
                                   case 4:
                                   {//品鉴心得详情
                                       
                                       DetailViewController *detailVc = [[DetailViewController alloc]init];
                                       detailVc.newsId = messageValueStr;
                                       detailVc.type = ExperienceDetailType;
                                       [self.navigationController pushViewController:detailVc animated:YES];
                                   }
                                       break;
                                   case 2:
                                   {//专业品鉴详情
                                       
                                       DetailViewController *detailVc = [[DetailViewController alloc]init];
                                       detailVc.newsId = messageValueStr;
                                       detailVc.type = ProfessionalDetailType;
                                       [self.navigationController pushViewController:detailVc animated:YES];
                                   }
                                       break;
                                   case 5:
                                   {//酒品详情
                                       
                                       DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
                                       dvc.wineID = messageValueStr;
                                       [self.navigationController pushViewController:dvc animated:YES];
                                   }
                                       break;
                                       /*
                                        case 5:
                                        {//酒庄详情
                                        WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
                                        wfc.WineFactoryID = messageValueStr;
                                        wfc.type = @"0";
                                        [self.navigationController pushViewController:wfc animated:YES];
                                        }
                                        break;
                                        case 6:
                                        {//品牌详情
                                        
                                        WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
                                        wfc.WineFactoryID = messageValueStr;
                                        wfc.type = @"1";
                                        [self.navigationController pushViewController:wfc animated:YES];
                                        }
                                        break;
                                        case 7:
                                        {//酒商详情
                                        WineShopDetailViewController *wdv = [[WineShopDetailViewController alloc]init];
                                        wdv.shopId = messageValueStr;
                                        [self.navigationController pushViewController:wdv animated:YES];
                                        }
                                        break;
                                        
                                        default:
                                        {
                                        
                                        }
                                        break;
                                        */
                               }

                           } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                               [loadingView removeFromSuperview];

                           }];
//    [getPushMessage requestWithParameters:dic withRequestUrl:url withIndicatorView:nil onRequestFinished:^(ITTBaseDataRequest *request) {
//        [loadingView removeFromSuperview];
//        if (![request.handleredResult[@"retCode"] isEqualToString:@"00000"]) {
//            return ;
//        }
//       // NSLog(@"message_type%@",request.handleredResult);
//        if(![request.handleredResult[@"retCode"] isEqualToString:@"00000"]){
//            return ;
//        }
//        NSArray *dataArr = request.handleredResult[@"data"];
//        //      NSLog(@"dataArrdataArr%@",dataArr.firstObject);
//        if (dataArr.count==0) {
//            return ;
//        }
//        NSDictionary *dataDic = dataArr.firstObject;
//
//        //      NSLog(@"bodyDic %@",dataDic[@"body"][@"messageContent"][@"content"][@"type"]);
//        //typeid:3_value:20
//        NSString *messageType = dataDic[@"body"][@"messageContent"][@"content"][@"type"];
//        NSArray *messageTypeArr = [messageType componentsSeparatedByString:@"_"];
//        NSString *messageTypeIdStr = (NSString *)messageTypeArr.firstObject;
//        NSString *messageTypeValueStr = (NSString *)messageTypeArr.lastObject;
//        NSString *messageIdStr = [self analyseStr:messageTypeIdStr];
//        NSString *messageValueStr = [self analyseStr:messageTypeValueStr];
//        
//       // NSLog(@"messageIdStr %@ %@",messageIdStr,messageValueStr);
//        
//        switch (messageIdStr.integerValue) {
//            case 3:
//            {//新闻详情
//                DetailViewController *detailVc = [[DetailViewController alloc]init];
//                detailVc.newsId = messageValueStr;
//                detailVc.type = NewsDetailType;
//                [self.navigationController pushViewController:detailVc animated:YES];
//            }
//                break;
//            case 4:
//            {//品鉴心得详情
//                
//                DetailViewController *detailVc = [[DetailViewController alloc]init];
//                detailVc.newsId = messageValueStr;
//                detailVc.type = ExperienceDetailType;
//                [self.navigationController pushViewController:detailVc animated:YES];
//            }
//                break;
//            case 2:
//            {//专业品鉴详情
//                
//                DetailViewController *detailVc = [[DetailViewController alloc]init];
//                detailVc.newsId = messageValueStr;
//                detailVc.type = ProfessionalDetailType;
//                [self.navigationController pushViewController:detailVc animated:YES];
//            }
//                break;
//            case 5:
//            {//酒品详情
//                
//                DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
//                dvc.wineID = messageValueStr;
//                [self.navigationController pushViewController:dvc animated:YES];
//            }
//                break;
//                /*
//            case 5:
//            {//酒庄详情
//                WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
//                wfc.WineFactoryID = messageValueStr;
//                wfc.type = @"0";
//                [self.navigationController pushViewController:wfc animated:YES];
//            }
//                break;
//            case 6:
//            {//品牌详情
//                
//                WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
//                wfc.WineFactoryID = messageValueStr;
//                wfc.type = @"1";
//                [self.navigationController pushViewController:wfc animated:YES];
//            }
//                break;
//            case 7:
//            {//酒商详情
//                WineShopDetailViewController *wdv = [[WineShopDetailViewController alloc]init];
//                wdv.shopId = messageValueStr;
//                [self.navigationController pushViewController:wdv animated:YES];
//            }
//                break;
//                
//            default:
//            {
//                
//            }
//                break;
//                 */
//        }
//        
//        
//    }];
    
}
#pragma mark - analyseStrMethod
//XX:XX
-(NSString *)analyseStr:(NSString *)src{
    
   NSRange range = [src rangeOfString:@":"];
    NSString *str;
    if (range.location != NSNotFound) {
        
        str = [src substringFromIndex:range.location+1];

    }
    return str;
}

#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"MessageCentureCellId";
    MessageCentreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell= [MessageCentreTableViewCell cellFromNib];
        //666666
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:218.0/255.f green:218.0/255.f blue:218.0/255.f alpha:1];
        
    }

//    PushMessage *message;
//    if (_dataArray) {
//        
//        message = _dataArray[_dataArray.count - indexPath.row-1];
//
//    }
    PushMessage *Pmessage = _dataArray[indexPath.row];
    
   // NSLog(@"消息列表-----%@",Pmessage.messageTitle);

    cell.dateLabel.text = [self timeFormat:Pmessage.messageTime];

    //cell上的线
    if (indexPath.row == 0) {
        
        cell.upLineLabel.hidden = YES;
        cell.downLineLabel.hidden = NO;
        
    } else if (indexPath.row == _dataArray.count-1){
        
        cell.upLineLabel.hidden = NO;
        cell.downLineLabel.hidden = YES;
        
    } else {
        
        cell.upLineLabel.hidden = NO;
        cell.downLineLabel.hidden = NO;
    }
    //只有一条消息
    if (_dataArray.count == 1) {
        cell.upLineLabel.hidden = YES;
        cell.downLineLabel.hidden = YES;
    }
    
    //不同消息上显示的图标
    if ([Pmessage.type isEqualToString: @"0"]) {
        
        //高温
        cell.pointAlertImageView.hidden = NO;
        cell.newsReadedImageView.hidden = YES;
        cell.pointNewsImageVeiw.hidden = YES;
        cell.pointAdImageView.hidden = YES;
        cell.contentLabel.text = Pmessage.messageContent;
        cell.dateLabel.text = [self timeFormat:Pmessage.messageTime];
        cell.contentLabel.textColor = [UIColor blackColor];
        
    } else if ([Pmessage.type isEqualToString: @"1"]) {
        
        //推送
        cell.pointAlertImageView.hidden = YES;
        cell.pointNewsImageVeiw.hidden = NO;
        cell.pointAdImageView.hidden = YES;
        cell.newsReadedImageView.hidden = YES;
        cell.contentLabel.text = Pmessage.messageTitle;
        cell.dateLabel.text = [self timeFormat:Pmessage.messageTime];
        cell.contentLabel.textColor = [UIColor blackColor];
        
    } else if ([Pmessage.type isEqualToString: @"2"]||[Pmessage.type isEqualToString: @"3"]){
        
        //已读
        cell.pointAlertImageView.hidden = YES;
        cell.pointNewsImageVeiw.hidden = YES;
        
        cell.contentLabel.textColor = [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:186/255.0f];
        if ([Pmessage.type isEqualToString: @"2"]) {
            
            //高温
            cell.contentLabel.text = Pmessage.messageContent;
            cell.dateLabel.text = [self timeFormat:Pmessage.messageTime];
            cell.pointAdImageView.hidden = NO;
            cell.newsReadedImageView.hidden = YES;
            
        } else {
            //推送消息
            cell.contentLabel.text = Pmessage.messageTitle;
            cell.dateLabel.text = [self timeFormat:Pmessage.messageTime];
            cell.pointAdImageView.hidden = YES;
            cell.newsReadedImageView.hidden = NO;
        }
    }
    
    if (_isEdit == NO) {
        
        cell.narrowImageView.hidden = NO;
        //非编辑状态
        cell.editImageView.hidden = YES;
        cell.editSelectedImageView.hidden = YES;
        
    } else {
        
    //编辑状态
        cell.narrowImageView.hidden = YES;
        cell.editImageView.hidden = NO;
        if ([_selectedIndexSet containsIndex:indexPath.row]) {
            
            cell.editSelectedImageView.hidden = NO;
            
        } else {
            
            cell.editSelectedImageView.hidden = YES;
            
        }
       // if()
        if (_isAllSelected) {
          //  cell.editSelectedImageView.hidden = NO;
            _allSelectButton.selected = YES;
        } else {
          //  cell.editSelectedImageView.hidden = YES;
            _allSelectButton.selected = NO;

        }
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushMessage *message = _dataArray[indexPath.row];
    MessageCentreTableViewCell *cell = (MessageCentreTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_isEdit == YES) {
        
        if (cell.editSelectedImageView.hidden == NO) {
            
            //取消选中
            cell.editSelectedImageView.hidden = YES;
            message.isChecked = NO;
            [_selectedIndexSet removeIndex:indexPath.row];
            

        } else {
            
            //选中
            message.isChecked = YES;
            cell.editSelectedImageView.hidden = NO;
            [_selectedIndexSet addIndex:indexPath.row];

        }
    } else {
        
        cell.pointAlertImageView.hidden = YES;
        cell.pointNewsImageVeiw.hidden = YES;
        cell.contentLabel.textColor = [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:186/255.0f];
    //进入消息详情页
        //       //0 高温消息 1推送消息 2高温已读消息 3推送已读 NSLog(@"message.typemessage.typemessage.typemessage.typemessage.type]]]]]]]]%@",message.type);
        if ([message.type isEqualToString: @"0"]||[message.type isEqualToString: @"2"]) {
            message.type = @"2";
            
            cell.pointAdImageView.hidden = NO;
            cell.newsReadedImageView.hidden = YES;
            
            AlertMessageDetailViewController *alertVc = [[AlertMessageDetailViewController alloc]init];
            alertVc.alertContent = message.messageContent;
            [self.navigationController pushViewController:alertVc animated:YES];
            
        } else if([message.type isEqualToString: @"1"]||[message.type isEqualToString: @"3"]){
            message.type = @"3";
            
            cell.pointAdImageView.hidden = YES;
            cell.newsReadedImageView.hidden = NO;
            
            if ([message.messageType isEqualToString:@"0"]) {
                
                DetailViewController *detailVc = [[DetailViewController alloc]init];
                detailVc.type = MessageDetailType;
                [self.navigationController pushViewController:detailVc animated:YES];
                
            } else if ([message.messageType isEqualToString:@"1"]){
                
                [self getCloudMessageRequest:message.messageContent];
                
            }
            
        }
        
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCentreTableViewCell *cell = (MessageCentreTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
}

#pragma mark -timeFormat method
-(NSString *)timeFormat:(NSString *)time
{
    
    NSString *ret;
    NSDate *dateNow = [NSDate date];
    NSDate *date = [NSDate dateWithString:time formate:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval interval = -[date timeIntervalSinceNow];
   // NSLog(@"interval %f",interval);
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
    [format2 setDateFormat:@"MM月dd日"];
    NSDateFormatter *format3 = [[NSDateFormatter alloc]init];
    [format3 setDateFormat:@"dd"];
    NSString* dayTime = [format3 stringFromDate:date];
    NSString* nowTime = [format3 stringFromDate:dateNow];
    NSInteger days = nowTime.integerValue - dayTime.integerValue;
    NSString* hourTime = [format stringFromDate:date];
    if (interval/86400 <= 1 && days == 0) {
        ret = [NSString stringWithFormat:@"今天 %@",hourTime];
   // } else if (interval/172800 <= 1 && days == 1){
    //    ret = [NSString stringWithFormat:@"昨天 %@",hourTime];
    } else {
        ret = [format2 stringFromDate:date];
    }
    return ret;
}

- (IBAction)selectButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    _isAllSelected = btn.selected;
    [_selectedIndexSet removeAllIndexes];
    if (_isAllSelected) {
        for (NSInteger i = 0; i < _dataArray.count; i++) {
            [_selectedIndexSet addIndex:i];
        }
        
    }
    [_tableView reloadData];
}

@end
