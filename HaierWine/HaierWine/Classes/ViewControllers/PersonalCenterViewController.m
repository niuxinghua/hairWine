//
//  PersonalCenterViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterTableViewCell.h"
#import "PKRevealController.h"
#import "UserInfoManager.h"
#import "Personal.h"
#import "NickNameViewController.h"
//#import "CityViewController.h"
@interface PersonalCenterViewController ()
{
    
    IBOutlet UITableView   *_personalTableView;
    NSIndexPath            *_indexPath;
    Personal               *_personal;
    NSString               *_avatarUrl;
    LoadingView            *_loadingView;
}

@end

@implementation PersonalCenterViewController
static PersonalCenterViewController *_personalCenterViewController;
+ (PersonalCenterViewController *)getPersonalCenterViewController
{
    return _personalCenterViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isUploadAvatarByAvatarDataSccess:) name:@"HEADIMAGE_SUCCESS" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _personalTableView.delegate = self;
    _personalTableView.dataSource = self;
    //_personalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _personalTableView.separatorColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    _personal = DATA_ENV.person;
    _personalCenterViewController = self;
      [self getPersonalRequest];
 //   NSLog(@"person=%@",DATA_ENV.person.userProfile.nickName);
//    if (!DATA_ENV.isLocalOnline) {
//        [CommomAlertView popAlertInViewController:self isMenuController:YES andAlertMessage:nil];
//    }
   // _personal = DATA_ENV.person;
//    if (_personal == nil) {
//        [self getPersonalRequest];
//    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self getPersonalRequest];

}

- (void)getPersonalRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

  //  loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:loadingView];
    [UserInfoManager queryUserInfoWhenCompletion:^(BOOL isSuccess, id responseObject) {
        if (isSuccess == YES) {
            _personal = DATA_ENV.person;
        }
     //   NSLog(@"person=%@",DATA_ENV.person.userProfile.nickName);
        [_personalTableView reloadData];
        [loadingView removeFromSuperview];

    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID = @"winePrice";
    PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [PersonalCenterTableViewCell cellFromNib];
    }
    switch (indexPath.row) {
        case 0:
            _indexPath = indexPath;
            cell.type = PersonalCenterCellTypeImage;
            cell.itemName.text = @"头像";
           // NSLog(@"头像头像头像%@",_personal.userProfile.avatarUrl);
           [cell.personImageView loadImage:_personal.userProfile.avatarUrl placeHolder:[UIImage imageNamed:@"menu_headImg.png"]];
           // cell.personImageView.image = [UIImage imageNamed:@"left_head"];
           // cell.personImageView.image = _personal.userProfile.avatarUrl;
            break;
        case 1:
            cell.itemName.text = @"昵称";
            cell.personInfo.text = _personal.userProfile.nickName;
            break;
        case 2:
            cell.itemName.text = @"性别";
           // NSLog(@"%@",_personal.userProfile.gender);
            if ([_personal.userProfile.gender isEqualToString:@"1"]){
                cell.personInfo.text = @"女";
            } else if([_personal.userProfile.gender isEqualToString:@"0"]){
                cell.personInfo.text = @"男";
            }
            break;
        case 3:
        {
            cell.itemName.text = @"年龄";
            if ([_personal.userProfile.age isEqualToString:@"20"]){
                cell.personInfo.text = @"25岁以下";
            } else if ([_personal.userProfile.age isEqualToString:@"28"]){
                cell.personInfo.text = @"26-30岁";
            } else if ([_personal.userProfile.age isEqualToString:@"33"]){
                cell.personInfo.text = @"31-35岁";
            }else if ([_personal.userProfile.age isEqualToString:@"40"]){
                cell.personInfo.text = @"36岁以上";
            }

            break;
        }
        case 4:
            cell.itemName.text = @"地区";
           // NSLog(@"_personal.userProfile.address%@",_personal.userProfile.address);
            if ([_personal.userProfile.address isEndWithString:@"nullnull"]||[_personal.userProfile.address isEndWithString:@"null#null"]) {
                cell.personInfo.text = @"未知地区";
            } else {
                NSArray *strArr = [_personal.userProfile.address componentsSeparatedByString:@"#"];
                NSString *str = [strArr componentsJoinedByString:@""];
                
                NSString *city = (NSString *)strArr.firstObject;
                NSString *country = (NSString *)strArr.lastObject;
                if ([city isEqualToString:country]) {
                    
                    str = strArr.firstObject;
                }
                cell.personInfo.text = str;
                
            }
            break;
        case 5:
            if (_personal.userBase.mobile) {
                cell.type = PersonalCenterCellTypeUnselected;
                cell.itemName.text = @"手机号";
                cell.personInfo.text = _personal.userBase.mobile;
            } else {
                cell.type = PersonalCenterCellTypeUnselected;
                cell.itemName.text = @"邮箱";
                cell.personInfo.text = _personal.userBase.email;

            }

            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else {
        return 44;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self showActionSheetWithTitle:@"修改头像" andButton1:@"拍照上传" andButton2:@"上传手机中的照片"andButton3:nil andButton4:nil withTag:0];
            break;
        case 1:
        {
            NickNameViewController *nickNameViewController = [[NickNameViewController alloc]init];
            nickNameViewController.nickName = _personal.userProfile.nickName;
            [self.navigationController pushViewController:nickNameViewController animated:YES];
            break;
        }
        case 2:
            [self showActionSheetWithTitle:nil andButton1:@"男" andButton2:@"女" andButton3:nil andButton4:nil withTag:1];
            break;
        case 3:
            [self showActionSheetWithTitle:nil andButton1:@"25岁以下" andButton2:@"26-30岁" andButton3:@"31-35岁"andButton4:@"36岁以上" withTag:2];
            break;
        case 4:
        {
//            CityListViewController *cvc = [[CityListViewController alloc]init];
//            cvc.delegate = self;
//            [self.navigationController pushViewController:cvc animated:YES];
          // PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            CityViewController *cityVc = [[CityViewController alloc]init];
            cityVc.city = _personal.userProfile.address;
           // NSLog(@"citycitycc%@",cell.personInfo.text);
            cityVc.delegate = self;
            [self.navigationController pushViewController:cityVc animated:YES];
            break;
        }
        case 5:
        {

            break;
        }
        default:
            break;
    }
}

- (void)showActionSheetWithTitle:(NSString*)title andButton1:(NSString*)button1 andButton2:(NSString*)button2 andButton3:(NSString*)button3 andButton4:(NSString*)button4 withTag:(NSInteger)tag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:title
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:button1, button2,button3 ,button4, nil];
    actionSheet.actionSheetStyle = 0;
    actionSheet.tag = tag;
    [actionSheet showInView:self.view];
}
#pragma mark - navButton

- (IBAction)backButtonClick:(id)sender
{
//    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController animated:YES completion:^(BOOL finished) {
//        if (finished) {
//            //                self.navigationController.revealController.recognizesPanningOnFrontView = YES;
//        }
//    }];
//
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];

}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *profileDict = @{};
  //  NSLog(@"buttonIndex--%d---%d",buttonIndex,actionSheet.tag);
    switch (actionSheet.tag) {
        case 0:
            if (buttonIndex == 0) {
                [self snapImage];
            } else if(buttonIndex == 1){
                [self pickImage];
            } else
            {
                return;
            }
            break;
        case 1:
        {
            if (buttonIndex == 0 ){
                profileDict = @{@"gender"  :@"0"};
            } else if (buttonIndex == 1 ){
                profileDict = @{@"gender"  :@"1"};
            } else
                return;
            break;
        }
        case 2:
        {
            NSString *str;
            if (buttonIndex == 0){
                str = @"20";
            } else if (buttonIndex == 1)
            {
                str = @"28";
            } else if (buttonIndex == 2){
                str = @"33";
            } else if (buttonIndex == 3){
                str = @"40";
            } else
            {
                return;
            }
        
            profileDict = @{@"age": str};
            break;
        }
            
            break;
        default:
            break;
    }
    
//    UIImage *image = [UIImage imageNamed:@"menu_headImg"];
//    NSData * headData = UIImagePNGRepresentation(image);
//
//    NSString *headstr = [headData base64Encoding];
    
//    NSDictionary * profileDict = @{@"nickName"   : @"小王",
//                                   @"avatarUrl"  : @"headstr",
//                                   @"age"        : @"20",
//                                   @"mobilePhone": @"123242343",
//                                   @"address"    : @"北京",
//                                   @"gender"     : @"1"
//                                   };
    NSDictionary * userProfile = @{@"userProfile": profileDict};
    [UserInfoManager modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
       // NSLog(@"####%@",returnMsg);
        [self getPersonalRequest];
    }];

}
#pragma mark - CityListDelegate

- (void)selectedCity:(NSString *)cityName
{
    NSDictionary * profileDict = @{@"address": cityName
                                   
                                   };
    NSDictionary * userProfile = @{@"userProfile": profileDict};
    [UserInfoManager modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
      //  NSLog(@"####%@",returnMsg);小张
        [self getPersonalRequest];
        
    }];
}

#pragma mark - 相册

- (void) snapImage{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypeCamera;
    ipc.delegate=self;
    ipc.allowsEditing=YES;
    [self presentModalViewController:ipc animated:YES];
    
}

//从相册里找
- (void) pickImage
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate=self;
    ipc.allowsEditing=YES;
    [self presentModalViewController:ipc animated:YES];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{
   // UIImage *img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
     UIImage* img = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera){
        //        UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil);
    }
    
    NSData * headData = UIImageJPEGRepresentation(img,0.3);
    _loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        _loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        _loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

   // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_loadingView];
    [UserInfoManager uploadAvatarByAvatarData:headData ext:@"jpg" showView:nil completion:^(BOOL isSuccess,id responseObject){
       // [NSThread sleepForTimeInterval:3];

        [_loadingView removeFromSuperview];

        if (isSuccess) {
            _avatarUrl = responseObject;
            [self modifyUserAvatarUrl:_avatarUrl];

           // [self modifyUserAvatarUrl:_avatarUrl];

        } else {
            [UIAlertView popupAlertByDelegate:self title:nil message:@"头像上传失败!" cancel:@"知道了" others:nil];
        }
        
    }];

    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)modifyUserAvatarUrl:(NSString * )avatarUrl
{
    //    if (![NSString isVaildString:avatarUrl]) {
    //        return;
    //    }
    
//    UserProfileModel * model = [[PersonInfoManager sharedPersonInfoManager] getUserProfile];
//    NSString * nickName = model.nickName ? model.nickName : @"";
//    NSDictionary * profileDict = @{@"nikeName": nickName,
//                                   @"avatarUrl":avatarUrl};
//    NSDictionary * userProfile = @{@"userProfile": profileDict};
//    [self modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
//        if (isSuccess) {
//            
//        }else{
//            //  [UIAlertView popupAlertByDelegate:nil title:@"提示" message:returnMsg];
//        }
//    }];
    if (avatarUrl.length==0) {
        return;
    }
    NSDictionary * profileDict = @{@"avatarUrl": avatarUrl
                                   
                                   };
    NSDictionary * userProfile = @{@"userProfile": profileDict};
    [UserInfoManager modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
        if (isSuccess) {
          //  [self getPersonalRequest];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)[_personalTableView cellForRowAtIndexPath:indexPath];
                [cell.personImageView loadImage:_avatarUrl placeHolder:[UIImage imageNamed:@"menu_headImg.png"]];
            DATA_ENV.userAvatarUrl = _avatarUrl;
        }
        //  NSLog(@"####%@",returnMsg);小张
    }];
    
}

- (void)isUploadAvatarByAvatarDataSccess:(BOOL)isOrNo
{
    isOrNo = YES;
    [_loadingView removeFromSuperview];
    if (isOrNo) {
        [self modifyUserAvatarUrl:_avatarUrl];
    } else {
        [UIAlertView popupAlertByDelegate:self title:nil message:@"头像上传失败!" cancel:@"知道了" others:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
