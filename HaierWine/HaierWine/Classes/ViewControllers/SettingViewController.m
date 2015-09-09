//
//  SettingViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "SellerJoinViewController.h"
#import "UnBundingDeviceViewController.h"
#import "FeedbackViewController.h"
#import "ChangePasswordViewController.h"
#import "PKRevealController.h"
#import "NewFeatureIntroViewController.h"
#import "AboutViewController.h"
#import "HelpMeViewController.h"
#import "settingGrayView.h"
#import "PKRevealController.h"
#import "SDImageCache.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "HaierDataCacheManager.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import "ArticleReadCach.h"

@interface SettingViewController ()
{
    
    IBOutlet UIScrollView           *_scrollView;
    IBOutlet UITableView            *_settingTableView;
    NewFeatureIntroViewController   *_newFeatureIntroViewController;
    AboutViewController             *_aboutViewController;
    HelpMeViewController            *_helpViewController;
    
    NSString                        *_url;
//    BOOL                            _isRequesting;
    BOOL                            _isNew;
    NSString                        *_no;
    NSInteger                       _viewType;
}

@end

@implementation SettingViewController

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
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.separatorColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
    _scrollView.contentSize = CGSizeMake(320, 580-44);
//    if (!DATA_ENV.isLocalOnline) {
//        _settingTableView.height = _settingTableView.height - 68;
//        _scrollView.contentSize = CGSizeMake(320, 580 - 68);
//    }
    [self startRequestMethod];
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;

   // _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!DATA_ENV.isLocalOnline) {
        _settingTableView.height = 580 - 68-44;
        _scrollView.contentSize = CGSizeMake(320, 580-44 - 68);
    } else {
        _settingTableView.height = 580-44;
        _scrollView.contentSize = CGSizeMake(320, 580-44);

    }

 //   [_settingTableView reloadData];
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;

        default:
            break;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"setting";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [SettingTableViewCell cellFromNib];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"声效开关";
                cell.type = SettingCellTypeSwitch;
                break;
            case 1:
                cell.titleLabel.text = @"酒商入驻申请";
                cell.type = SettingCellTypeText;
                break;
            case 2:
                cell.titleLabel.text = @"设备信息";
                cell.type = SettingCellTypeText;
                break;
            case 3:
                cell.titleLabel.text = @"意见反馈";
                cell.type = SettingCellTypeText;
                break;
//            case 4:
//                cell.titleLabel.text = @"修改密码";//检查更新"
//                cell.type = SettingCellTypeText;
//                break;
            case 4:
                cell.titleLabel.text = @"清除缓存";
                cell.type = SettingCellTypeText;
                cell.hasLine = NO;
                break;
//            case 6:
//                cell.type = SettingCellTypeGray;
//                cell.titleLabel.text = @" ";
//                break;
//                
//     
//            case 11:
//                cell.type = SettingCellTypeGray;
//                cell.titleLabel.text = @" ";
//                break;
//            case 12:
//                cell.titleLabel.text = @"退出登录";
//                cell.type = SettingCellTypeText;
//                break;
//            case 13:
//                cell.type = SettingCellTypeGray;
//                cell.titleLabel.text = @" ";
//                break;
                
                
            default:
                break;
                
        }
    } else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"检查更新";
                cell.type = SettingCellTypeNewVersion;
                if (_isNew) {
                    cell.updateVersionImageVIew.hidden = NO;
                    cell.updateVersionLabel.hidden = NO;
                }
                break;
            case 1:
                cell.titleLabel.text = @"新版功能介绍";
                cell.type = SettingCellTypeText;
                break;
            case 2:
                cell.titleLabel.text = @"关于";
                cell.type = SettingCellTypeText;
                break;
            case 3:
                cell.titleLabel.text = @"帮助";
                cell.type = SettingCellTypeText;
                cell.hasLine = NO;
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"退出登录";
            cell.type = SettingCellTypeText;
            cell.hasLine = NO;
        }
    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    settingGrayView *view = [settingGrayView loadFromXib];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
switch (indexPath.section) {
    case 0:
    {
        switch (indexPath.row)
        {
            case 1:
            {
                SellerJoinViewController *sellerJoinViewController = [[SellerJoinViewController alloc]init];
                [self.navigationController pushViewController:sellerJoinViewController animated:YES];
                
                break;
                
            }
            case 2:
            {
                if (DATA_ENV.isLocalOnline) {
                    [self goUnBundingDeviceViewController];
                } else {
                    [self presentLoginViewController];
                    _viewType = 0;
                }
                
                //                    UnBundingDeviceViewController *unBundingDeviceViewController = [[UnBundingDeviceViewController alloc]init];
                //                    [self.navigationController pushViewController:unBundingDeviceViewController animated:YES];
                break;
                
            }
            case 3:
            {
                if (DATA_ENV.isLocalOnline) {
                    [self goFeedbackViewController];
                } else {
                    [self presentLoginViewController];
                    _viewType = 2;
                }
                break;
            }
//            case 4:
//            {
//                if (DATA_ENV.isLocalOnline) {
//                    [self goChangPasswordView];
//                } else {
//                    [self presentLoginViewController];
//                    _viewType = 1;
//                }
//                
//                break;
//            }
            case 4:
            {
                //                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"你确定要清理缓存吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
                //                    alertView.tag = 0;
                //                    [alertView show];
                [ITTImageView removeITTImageViewCache];
                [ArticleReadCach cleanArticleReadCach];
                [[HaierDataCacheManager sharedManager] removeAllData];
                [UIAlertView popupAlertByDelegate:nil title:nil message:@"清除缓存成功"];
                break;
            }
            default:
                break;
                
        }
        
        break;
    }
    case 1:
    {
        switch (indexPath.row)
        {
            case 0:
            {
                //                    if (_isRequesting == NO) {
                //                        [self updateRequestMethod];
                //                    }
                //                    NSLog(@"123");
                if (_isNew) {
                    
                    UpdateAlertView *alertView = [UpdateAlertView loadFromXib];
                    alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
                    alertView.delegate = self;
                    alertView.textLabel.text = _no;
                    [self.view addSubview:alertView];
                    
                } else {
                    
                    //   [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"当前版本已是最新版本"];
                    
                    FeedBackAndUpdateAlertView *alertView = [FeedBackAndUpdateAlertView loadFromXib];
                    alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
                    alertView.type = UpdateNotNeed;
                    [self.view addSubview:alertView];
                    
                }
                
            }
                break;
            case 1://新版功能介绍
            {
                NewFeatureIntroViewController  *newFeatureIntroViewController = [[NewFeatureIntroViewController alloc]init];
                [self.navigationController pushViewController:newFeatureIntroViewController animated:YES];
                break;
            }
            case 2: //关于
            {
                AboutViewController *aboutViewController = [[AboutViewController alloc]init];
                [self.navigationController pushViewController:aboutViewController animated:YES];
                break;
            }
            case 3://帮助
            {
                
                HelpMeViewController *helpMeViewController = [[HelpMeViewController alloc]init];
                [self.navigationController pushViewController:helpMeViewController animated:YES];
                break;
            }
            default:
                break;
                
        }
        break;
    }
    case 2:
    {
        if (indexPath.row == 0){
            {
                if (DATA_ENV.isVistor) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"你尚未登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    alertView.tag = 0;
                    [alertView show];
                    return;
                }
                else {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定要退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    alertView.tag = 11;
                    [alertView show];
                }
                
            }
        }
        break;
    }
        
    default:
        break;
}
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5 ||indexPath.row == 10 ||indexPath.row == 12) {
        return 32;
    }
    return 44;
}

- (IBAction)backButton:(id)sender
{
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
  //  [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
//    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
//    {
//        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
//    }
//    else
//    {
//        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - startRequest method
-(void)startRequestMethod
{
   // _isRequesting = YES;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"ios" forKey:@"type"];
    [UpdateRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
      //  NSLog(@"版本更新 %@",request.handleredResult);
        if ([request isSuccess]) {
            _no = request.handleredResult[@"data"][@"no"];
            NSString *newVirsion = [_no substringFromIndex:1];
       //     _no =
            _url = request.handleredResult[@"data"][@"url"];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//CFBundleShortVersionString
            NSString *currentNo = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            currentNo = [currentNo substringFromIndex:1];
            
            if ([newVirsion isEqualToString:currentNo]) {
             
                
            } else {
                _isNew = YES;
                [_settingTableView reloadData];
                
            }
        //    _isRequesting = NO;
        }
        
        
    } onRequestCanceled:nil onRequestFailed:nil];
}
#pragma mark - updateAlertView delegate
- (void)UpdateAlertViewClickedWithTag:(NSInteger)tag
{
    if (tag == 0) {
 //       NSLog(@"0");
    } else {
 //       NSLog(@"1");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url]];
    }
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 0:
        {
            break;
        }
        case 1:
            if (buttonIndex == 1) {
                
                //升级
                
            }
            break;
        case 11:
            if (buttonIndex == 0) {
                return;
            } else {
                LoadingView *loadingView = [LoadingView loadFromXib];
                if (isIOS7()) {
                    
                    loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
                } else {
                    
                    loadingView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height);
                }
                
                //  loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
                
                [self.view addSubview:loadingView];
                [LoginManager logoutRequestWhenCompletion:^(BOOL isSuccess, NSString *returnMsg) {
                  //  NSString *message;
                    [loadingView removeFromSuperview];
                    if (isSuccess) {
                   //     message = @"退出成功";
                        DATA_ENV.isLocalOnline = NO;
                        DATA_ENV.isBindingDevice = NO;
                        DATA_ENV.isVistor = YES;
                        //DATA_ENV.userName = nil;
                        DATA_ENV.userPassword = nil;
                        DATA_ENV.userid = nil;
                        DATA_ENV.wineName = nil;
                        DATA_ENV.wineType = nil;
                        DATA_ENV.userNickName = nil;
                        DATA_ENV.userAvatarUrl  = nil;
                       // NSArray *array = [[NSArray alloc]init];
                        //DATA_ENV.pushMessageArray = nil;
                      //  DATA_ENV.pushMessageArray = array;
                        //首页
                     //   [self.delegate showHomeViewController];
                        [[WineManager shareWineManager] cancelSubscribeDevice];
                        
                        [[MenuViewController getMenuViewController] showHomeViewControllerWith:NO];
                        
                        
                    } else {
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请求失败,请稍后重试。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [alertView show];
                    }
                    
                }];

            }
            break;
        default:
            break;
    }
  
}

#pragma mark - goUnBundingDeviceViewController

- (void)goUnBundingDeviceViewController
{
    UnBundingDeviceViewController *unBundingDeviceViewController = [[UnBundingDeviceViewController alloc]init];
    [self.navigationController pushViewController:unBundingDeviceViewController animated:YES];
}

- (void)goChangPasswordView
{
    ChangePasswordViewController *changePasswordViewController = [[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:changePasswordViewController animated:YES];
}

- (void)goFeedbackViewController
{
    FeedbackViewController *feedbackViewController = [[FeedbackViewController alloc]init];
    [self.navigationController pushViewController:feedbackViewController animated:YES];
}

#pragma mark - PresentLoginViewController

- (void)presentLoginViewController
{
    CommomAlertView *alertView = [CommomAlertView loadFromXib];
    alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
    alertView.delegate = self;
    [[AppDelegate getAppDelegate].window addSubview:alertView];
    //    [self.view addSubview:alertView];
    //  [CommomAlertView popAlertInViewController:self];
}

- (void)CommonAlertViewClickedWithTag:(NSInteger)tag
{
    if (tag == 1) {
        LoginViewController *nwvc = [[LoginViewController alloc]init];
        nwvc.delegate = self;
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nwvc];
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
    }
}

- (void)loginSuccess
{
    if (_viewType == 0) {
        [self goUnBundingDeviceViewController];
    } else if (_viewType == 1) {
        [self goChangPasswordView];
    } else if (_viewType == 2){
        [self goFeedbackViewController];
    }
}

@end
