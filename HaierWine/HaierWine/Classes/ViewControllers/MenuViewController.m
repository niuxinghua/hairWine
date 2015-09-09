//
//  MenuViewController.m
//  HaierWine
//
//  Created by leon on 14-6-26.
//
//

#import "MenuViewController.h"
#import "PKRevealController.h"
//#import "OneViewController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "MyLoveWineViewController.h"
#import "PersonalCenterViewController.h"
#import "NewsViewController.h"
#import "LoginViewController.h"
#import "ITTImageView.h"
#import "ExperienceViewController.h"
#import "ProfessionalViewController.h"
#import "MessageCentreViewController.h"
#import "MyBrowseViewController.h"
#import "BaseNavigationController.h"
#import "PushMessage.h"
#import "AppDelegate.h"

@interface MenuViewController ()<SettingViewControllerDelegate>
{
    
    IBOutlet UIButton        *_wineBoxButton;
    IBOutlet UIView          *_headView;
    IBOutlet UIButton        *_homeButton;
    IBOutlet UIButton        *_vedioBtn;
    IBOutlet UILabel         *_userName;
    IBOutlet ITTImageView    *_userImageView;
    IBOutlet UIView          *_showMessageImageView;
    IBOutlet UILabel         *_showMessageLabel;
    
    UIButton                 *_selectedButton;
    NSInteger                _viewType;
    BOOL                     _isMainView;
}

@end

@implementation MenuViewController
static MenuViewController *_menuViewController;
+ (MenuViewController *)getMenuViewController
{
    return _menuViewController;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailMessageController) name:@"SHOWDETAILMESSAGE" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButton:) name:@"CHANGEBUTTON" object:nil];
        _isMainView = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changIcon) name:@"RECEIVEPUSHMESSAGE"  object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
    [self.revealController setMinimumWidth:250.0f maximumWidth:250.0f forViewController:self];
    _selectedButton = _homeButton;
    _selectedButton.selected = YES;
    _showMessageImageView.hidden = YES;
    _menuViewController = self;
}

-(void)initView
{
    _headView.layer.cornerRadius = 25;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (DATA_ENV.isLocalOnline) {
        _userName.text = DATA_ENV.userNickName;
      //  NSLog(@"头像头像头像头像--%@",DATA_ENV.userAvatarUrl);
        [_userImageView loadImage:DATA_ENV.userAvatarUrl placeHolder:[UIImage imageNamed:@"menu_headImg.png"]];
        if (DATA_ENV.userAvatarUrl.length==0) {
            _userImageView.image = [UIImage imageNamed:@"menu_headImg.png"];
        }
    } else {
        _userName.text = @"";
        _userImageView.image = [UIImage imageNamed:@"menu_headImg.png"];
    }
    [self changIcon];
    //NSLog(@"nickName--%@",DATA_ENV.person.userProfile.nickName);
   // NSLog(@"avatarUrl--%@",DATA_ENV.person.userProfile.avatarUrl);
    //判断通知数


//    }
}

- (void)changIcon
{
    NSArray *arr = DATA_ENV.pushMessageArray;
    NSInteger count = 0;
    //    if (arr !=nil ) {
    for (int i = 0; i < arr.count; i++) {
        PushMessage *message = arr[i];
        
        // NSLog(@"message    mm%@",message);
        
        if (!([message.type isEqualToString: @"2"]||[message.type isEqualToString: @"3"])) {
            
            count++;
        }
    }
    if (count == 0) {
        
        _showMessageImageView.hidden = YES;
        
    } else {
        
        _showMessageImageView.hidden = NO;
        _showMessageLabel.text = [NSString stringWithFormat:@"%d",count];
    }
}
#pragma mark - Button Methods

- (void)changeButton:(NSNotification *)noti
{
  //  UIButton *btn;
    _selectedButton.selected = NO;
    NSString *str = [noti userInfo][@"button"];
    if ([str isEqualToString:@"rightButton"]) {
        _selectedButton = _wineBoxButton;

    } else {
        _selectedButton = _homeButton;
    }
   // _selectedButton = btn;
    _selectedButton.selected = YES;
  //  _wineBoxButton.selected = YES;
  //  NSLog(@"通知通知--%d",_wineBoxButton.selected);
}

- (IBAction)onHomeButton:(id)sender
{
    MainViewController *main = [[MainViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:main];
    nav.hidesBottomBarWhenPushed = YES;
    nav.navigationBarHidden = YES;
    [self.revealController setFrontViewController:nav focusAfterChange:YES completion:^(BOOL finished) {
        
    }];
}

-(IBAction)btnClick:(id)sender
{
    _selectedButton.selected = NO;
    UIButton* btn = (UIButton *)sender;
    _selectedButton = btn;
    _selectedButton.selected = YES;
    switch (btn.tag) {
            
        case 101:
        {
            if (!_isMainView) {
                [self pushMainViewIsWineBox:NO];
                _isMainView = YES;
            }
        //首页
//            MainViewController *mvc = [[MainViewController alloc]init];
//            mvc.isNoShowLogin = YES;
//            mvc.isWineBox = NO;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//            nvc.navigationBarHidden = YES;
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
//            [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController animated:YES completion:^(BOOL finished) {
//            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MainView" object:nil];

        }
            break;
            
        case 102:
        {
            if (!_isMainView) {
                [self pushMainViewIsWineBox:YES];
                _isMainView = YES;
            }

//        //我的酒柜
//            MainViewController *mvc = [[MainViewController alloc]init];
//            if (DATA_ENV.isLocalOnline)
//            {
//                mvc.isNoShowLogin = YES;
//            } else {
//                mvc.isNoShowLogin = NO;
//            }
//            mvc.isWineBox = YES;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//            nvc.navigationBarHidden = YES;
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
            if (DATA_ENV.isLocalOnline)
            {
                [self goWineControlView];
            } else {
                [self presentLoginViewController];
                _viewType = 1;
                //mvc.isNoShowLogin = NO;
            }
        }
            break;
            
        case 103:
        {
//        //我的爱酒
//            MyLoveWineViewController *mvc = [[MyLoveWineViewController alloc]init];
//            mvc.navTitle = @"我的爱酒";
//            mvc.text = @"没有收藏爱酒";
//            mvc.imageName = @"mylove_noWine";
//            mvc.type = @"2";
////            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
////            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
////                
////            }];
//           // [self.revealController.navigationController pushViewController:mvc animated:YES];
//            [(BaseNavigationController*)self.revealController.frontViewController pushViewController:mvc animated:YES];
//            [self.revealController showViewController:self.revealController.frontViewController];
            if (DATA_ENV.isLocalOnline)
            {
                [self goMyLoveWineView];
            } else {
                [self presentLoginViewController];
                _viewType = 2;
                //mvc.isNoShowLogin = NO;
            }


        }
            break;
            
        case 104:
        {
//         //我的浏览
//            MyLoveWineViewController *mvc = [[MyLoveWineViewController alloc]init];
//            mvc.navTitle = @"我的浏览";
//            mvc.text = @"没有浏览记录";
//            mvc.imageName = @"myskim_noRecord";
//            mvc.type = @"1";
//            [(BaseNavigationController*)self.revealController.frontViewController pushViewController:mvc animated:YES];
//            [self.revealController showViewController:self.revealController.frontViewController];
            if (DATA_ENV.isLocalOnline)
            {
                [self goMyBrose];
            } else {
                [self presentLoginViewController];
                _viewType = 3;
                //mvc.isNoShowLogin = NO;
            }
        }
            break;
            
        case 105:
        {
        //新闻
//            MainViewController *mvc = [[MainViewController alloc]init];
//            mvc.isNoShowLogin = YES;
//            mvc.isWineBox = NO;
//            _mainViewController.isNoShowLogin = YES;
//            _mainViewController.isWineBox = NO;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:_mainViewController];
//            nvc.navigationBarHidden = YES;
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
//
//            NewsViewController *nwvc = [[NewsViewController alloc]init];
//            [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
//            [self.revealController showViewController:self.revealController.frontViewController];
//            
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
            _isMainView = NO;
            NewsViewController *professionalVc = [[NewsViewController alloc]init];
            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:professionalVc];
            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
                
            }];

        }
            break;
            
        case 106:
        {
        //专业品鉴
//            MainViewController *mvc = [[MainViewController alloc]init];
//            mvc.isNoShowLogin = YES;
//            mvc.isWineBox = NO;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//            _mainViewController.isNoShowLogin = YES;
//            _mainViewController.isWineBox = NO;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:_mainViewController];
//            nvc.navigationBarHidden = YES;
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
//            
//            ProfessionalViewController *nwvc = [[ProfessionalViewController alloc]init];
//            [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
//            [self.revealController showViewController:self.revealController.frontViewController];
//            
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
            _isMainView = NO;

            ProfessionalViewController *professionalVc = [[ProfessionalViewController alloc]init];
            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:professionalVc];
            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        default:
        {
        //品鉴心得
//            MainViewController *mvc = [[MainViewController alloc]init];
//            mvc.isNoShowLogin = YES;
//            mvc.isWineBox = NO;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//            _mainViewController.isNoShowLogin = YES;
//            _mainViewController.isWineBox = NO;
//            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:_mainViewController];
//            nvc.navigationBarHidden = YES;
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
//            
//            ExperienceViewController *nwvc = [[ExperienceViewController alloc]init];
//            [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
//            [self.revealController showViewController:self.revealController.frontViewController];
//            
//            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//                
//            }];
            _isMainView = NO;

            ExperienceViewController *experienceVc = [[ExperienceViewController alloc]init];
            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:experienceVc];
            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
                
            }];
        }
            break;
    }
    
}

#pragma mark - goSomeViewController

- (void)pushMainViewIsWineBox:(BOOL)is
{
//    MainViewController *mvc = [[MainViewController alloc]init];
//    mvc.isNoShowLogin = YES;
//    mvc.isWineBox = is;
    _mainViewController.isNoShowLogin = YES;
    _mainViewController.isWineBox = is;
    BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:_mainViewController];
    nvc.navigationBarHidden = YES;
  //  [self.revealController setFrontViewController:nvc];

    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {

    }];
    self.navigationController.revealController.recognizesPanningOnFrontView = YES;

    [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController animated:YES completion:^(BOOL finished) {
    }];
//
}

- (void)goWineControlView
{
    //我的酒柜
//    MainViewController *mvc = [[MainViewController alloc]init];
////    if (DATA_ENV.isLocalOnline)
////    {
////        mvc.isNoShowLogin = YES;
////    } else {
////        mvc.isNoShowLogin = NO;
////    }
//    mvc.isNoShowLogin = YES;
//    mvc.isWineBox = YES;
//    BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//    nvc.navigationBarHidden = YES;
//    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//        
//    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ControlWine" object:nil];

}

- (void)goMyLoveWineView
{
    //我的爱酒
    _isMainView = NO;
    MyLoveWineViewController *mvc = [[MyLoveWineViewController alloc]init];
    mvc.navTitle = @"我的爱酒";
    mvc.text = @"没有收藏爱酒";
    mvc.imageName = @"mylove_noWine";
    mvc.type = @"2";
    //            BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
    //            [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
    //
    //            }];
    // [self.revealController.navigationController pushViewController:mvc animated:YES];
    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:mvc animated:NO];
    [self.revealController showViewController:self.revealController.frontViewController];
}

- (void)goMyBrose
{
    //我的浏览
    _isMainView = NO;
    MyLoveWineViewController *mvc = [[MyLoveWineViewController alloc]init];
    mvc.navTitle = @"我的浏览";
    mvc.text = @"没有浏览记录";
    mvc.imageName = @"myskim_noRecord";
    mvc.type = @"1";
    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:mvc animated:NO];
    [self.revealController showViewController:self.revealController.frontViewController];
}

- (void)goPersonalView
{
    _isMainView = NO;
    PersonalCenterViewController *pcv = [[PersonalCenterViewController alloc]init];
    [self.revealController showViewController:self.revealController.frontViewController];

    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:pcv animated:NO];
    //[self.revealController showViewController:self.revealController.frontViewController];
}

- (void)goMessageCenter
{
    _isMainView = NO;
    MessageCentreViewController *messageCentreVc = [[MessageCentreViewController alloc]init];
    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:messageCentreVc animated:NO];
    [self.revealController showViewController:self.revealController.frontViewController];
    
}

-(IBAction)mine:(id)sender
{
    _selectedButton.selected = NO;
    if (DATA_ENV.isLocalOnline)
    {
//    PersonalCenterViewController *pcv = [[PersonalCenterViewController alloc]init];
//    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:pcv animated:YES];
//    [self.revealController showViewController:self.revealController.frontViewController];
        [self goPersonalView];
    } else {
        [self presentLoginViewController];
        _viewType = 0;
//        LoginViewController *nwvc = [[LoginViewController alloc]init];
//        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nwvc];
//        [self presentViewController:nvc animated:YES completion:^{
//            
//        }];
        //[self presentModalViewController:nwvc animated:YES];
//        [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
//        [self.revealController showViewController:self.revealController.frontViewController];
    }

}

-(IBAction)setting:(id)sender
{
    _selectedButton.selected = NO;
//    MainViewController *mvc = [[MainViewController alloc]init];
//    mvc.isNoShowLogin = YES;
//    mvc.isWineBox = NO;
//    BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//    _mainViewController.isNoShowLogin = YES;
//    _mainViewController.isWineBox = NO;
//    BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:_mainViewController];
//    nvc.navigationBarHidden = YES;
//    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//        
//    }];
    _isMainView = NO;
    SettingViewController *nwvc = [[SettingViewController alloc]init];
    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
    [self.revealController showViewController:self.revealController.frontViewController];
    
//    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//        
//    }];

//    _isMainView = NO;
//    SettingViewController *svc = [[SettingViewController alloc]init];
//    svc.delegate = self;
//    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:svc animated:NO];
//    [self.revealController showViewController:self.revealController.frontViewController];
}

-(IBAction)vedioBtn:(id)sender{

    [self vedio:_vedioBtn];
    
}

-(IBAction)vedio:(id)sender{
//消息中心
    if (DATA_ENV.isLocalOnline)
    {
        //    PersonalCenterViewController *pcv = [[PersonalCenterViewController alloc]init];
        //    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:pcv animated:YES];
        //    [self.revealController showViewController:self.revealController.frontViewController];
        [self goMessageCenter];
    } else {
        [self presentLoginViewController];
        _viewType = 4;
        //        LoginViewController *nwvc = [[LoginViewController alloc]init];
        //        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nwvc];
        //        [self presentViewController:nvc animated:YES completion:^{
        //
        //        }];
        //[self presentModalViewController:nwvc animated:YES];
        //        [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
        //        [self.revealController showViewController:self.revealController.frontViewController];
    }

//    MessageCentreViewController *messageCentreVc = [[MessageCentreViewController alloc]init];
//    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:messageCentreVc animated:NO];
//    [self.revealController showViewController:self.revealController.frontViewController];
    
}

#pragma mark - SettingViewControllerDelegate

-(void)showHomeViewControllerWith:(BOOL)left
{
//    MainViewController *mvc = [[MainViewController alloc]init];
//    mvc.isNoShowLogin = left;
//    mvc.isWineBox = left;
    _mainViewController.isNoShowLogin = left;
    _mainViewController.isWineBox = left;
    BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:_mainViewController];
    nvc.navigationBarHidden = YES;
    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
        
    }];
}

//- (void)dd:(NSNotification *)notic
//{
//    _isMainView = NO;
//    MessageCentreViewController *messageCentreVc = [[MessageCentreViewController alloc]init];
//    messageCentreVc.isDetail = YES;
//    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:messageCentreVc animated:NO];
//    [self.revealController showViewController:self.revealController.frontViewController];
//}

- (void)showDetailMessageController
{
//    MainViewController *mvc = [[MainViewController alloc]init];
//    mvc.isNoShowLogin = YES;
//    mvc.isWineBox = NO;
//    BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//    nvc.navigationBarHidden = YES;
//    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//        
//    }];
//    
//    SettingViewController *nwvc = [[SettingViewController alloc]init];
//    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:nwvc animated:YES];
//    [self.revealController showViewController:self.revealController.frontViewController];
//    
//    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//        
//    }];

    _isMainView = NO;
    MessageCentreViewController *messageCentreVc = [[MessageCentreViewController alloc]init];
    messageCentreVc.isDetail = YES;
    [(BaseNavigationController*)self.revealController.frontViewController pushViewController:messageCentreVc animated:NO];
    [self.revealController showViewController:self.revealController.frontViewController];
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

#pragma mark - LoginDelegate

- (void)loginSuccess
{
    if (_viewType == 0) {
        [self goPersonalView];
    } else if (_viewType == 1) {
        [self goWineControlView];
    } else if (_viewType == 2) {
        [self goMyLoveWineView];
    } else if (_viewType == 3) {
        [self goMyBrose];
    } else if (_viewType == 4) {
        [self goMessageCenter];
    }
}
@end
