//
//  NetTestViewController.m
//  HaierWine
//
//  Created by david on 14/7/10.
//
//

#import "NetTestViewController.h"

@interface NetTestViewController ()

@end

@implementation NetTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//logo图
-(IBAction)LogoClick:(id)sender
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:@"ios" forKey:@"type"];
    [parameters setValue:@"p" forKey:@"picSize"];
    [LogoRequest requestWithParameters:parameters
                     withIndicatorView:self.view
                     withCancelSubject:nil
                        onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                            if ([request isSuccess]) {
                                NSLog(@"logo---返回值---%@",request.handleredResult);
                            }
                        } onRequestCanceled:nil
                       onRequestFailed:^(ITTBaseDataRequest *request) {
                           [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                       }];
    
    
}
//开机闪图
-(IBAction)StartLogoClick:(id)sender
{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:@"ios" forKey:@"type"];
    [parameters setValue:@"p" forKey:@"picSize"];
    [StartLogoRequest requestWithParameters:parameters
                          withIndicatorView:self.view
                          withCancelSubject:nil
                             onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                 if ([request isSuccess]) {
                                     NSLog(@"开机闪图---返回值---%@",request.handleredResult);
                                 }
                             } onRequestCanceled:nil
                            onRequestFailed:^(ITTBaseDataRequest *request) {
                                [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                            }];
    
}
//首页
-(IBAction)HomePageClick:(id)sender
{

    [HomePageRequest requestWithParameters:nil
                         withIndicatorView:self.view
                         withCancelSubject:nil
                            onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                if ([request isSuccess]) {
                                    NSLog(@"---返回值---%@",request.handleredResult);
                                }
                            } onRequestCanceled:nil
                           onRequestFailed:^(ITTBaseDataRequest *request) {
                               [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                           }];
    
}
//城镇查询
-(IBAction)CountryClick:(id)sender
{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:@"1" forKey:@"country_id"];
    [CountryRequest requestWithParameters:parameters
                        withIndicatorView:self.view
                        withCancelSubject:nil
                           onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                               if ([request isSuccess]) {
                                NSLog(@"城镇查询---返回值---%@",request.handleredResult);   
                               }
                           } onRequestCanceled:nil
                          onRequestFailed:^(ITTBaseDataRequest *request) {
                              [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                          }];
    
}
//酒品收藏
-(IBAction)favouriteWineClick:(id)sender
{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:@"2" forKey:@"goodsId"];
    [parameters setValue:@"1" forKey:@"appId"];
    [parameters setValue:@"1" forKey:@"merchantsId"];
    [FavouriteWineRequest requestWithParameters:parameters
                        withIndicatorView:self.view
                        withCancelSubject:nil
                           onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                               if ([request isSuccess]) {
                                 NSLog(@"酒品收藏---返回值---%@",request.handleredResult);
                               }
                           } onRequestCanceled:nil
                          onRequestFailed:^(ITTBaseDataRequest *request) {
                              [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                          }];
    
}
//酒品收藏列表
-(IBAction)favouriteWineListClick:(id)sender
{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    [parameters setValue:@"1" forKey:@"appId"];
    
    [FavouriteWineListRequest requestWithParameters:parameters
                        withIndicatorView:self.view
                        withCancelSubject:nil
                           onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                               if ([request isSuccess]) {
                                  
                               }
                           } onRequestCanceled:nil
                          onRequestFailed:^(ITTBaseDataRequest *request) {
                              [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                          }];
    
}
//酒品收藏删除
-(IBAction)favouriteWineDeleteClick:(id)sender{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //goodsId=2&appId=1&merchantsId=1
    [parameters setValue:@"1" forKey:@"appId"];
    [parameters setValue:@"2" forKey:@"goodsId"];
    [parameters setValue:@"1" forKey:@"merchantsId"];
    
    [FavouriteWineDeleteRequest requestWithParameters:parameters
                                  withIndicatorView:self.view
                                  withCancelSubject:nil
                                     onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                         if ([request isSuccess]) {
                                             
                                         }
                                     } onRequestCanceled:nil
                                    onRequestFailed:^(ITTBaseDataRequest *request) {
                                        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                    }];
}
//版本升级
-(IBAction)updateClick:(id)sender{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //type=ios
    [parameters setValue:@"ios" forKey:@"type"];
    
    [UpdateRequest requestWithParameters:parameters
                                  withIndicatorView:self.view
                                  withCancelSubject:nil
                                     onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                         if ([request isSuccess]) {
                                             
                                         }
                                     } onRequestCanceled:nil
                                    onRequestFailed:^(ITTBaseDataRequest *request) {
                                        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                    }];
}

//扫描条形码空接口
-(IBAction)barcodeClick:(id)sender{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //codekey=2007
    [parameters setValue:@"2007" forKey:@"codekey"];
    
    [BarcodeRequest requestWithParameters:parameters
                                  withIndicatorView:self.view
                                  withCancelSubject:nil
                                     onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                         if ([request isSuccess]) {
                                             
                                         }
                                     } onRequestCanceled:nil
                                    onRequestFailed:^(ITTBaseDataRequest *request) {
                                        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                    }];
}
//酒品搜索
-(IBAction)searchWineClick:(id)sender{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //goodsName=红
    NSString *str = @"红";
    [parameters setValue:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"name"];
    NSLog(@"----%@",parameters);
    [SearchWineRequest requestWithParameters:parameters
                                  withIndicatorView:self.view
                                  withCancelSubject:nil
                                     onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                         if ([request isSuccess]) {
                                             
                                         }
                                     } onRequestCanceled:nil
                                    onRequestFailed:^(ITTBaseDataRequest *request) {
                                        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                    }];
}
//酒庄详情
-(IBAction)wineParkDetailClick:(id)sender{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //id=1
    [parameters setValue:@"1" forKey:@"id"];
    
    [WineParkDetailRequest requestWithParameters:parameters
                                  withIndicatorView:self.view
                                  withCancelSubject:nil
                                     onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                         if ([request isSuccess]) {
                                             
                                         }
                                     } onRequestCanceled:nil
                                    onRequestFailed:^(ITTBaseDataRequest *request) {
                                        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                    }];
}
//名酒庄
-(IBAction)famousWineParkClick:(id)sender{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //appchateaulist?page=1
    [parameters setValue:@"1" forKey:@"page"];
    
    [FamousParkWineRequest requestWithParameters:parameters
                                  withIndicatorView:self.view
                                  withCancelSubject:nil
                                     onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                         if ([request isSuccess]) {
                                             
                                         }
                                     } onRequestCanceled:nil
                                    onRequestFailed:^(ITTBaseDataRequest *request) {
                                        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                    }];
}
@end
