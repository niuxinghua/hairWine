//
//  CityViewController.m
//  HaierWine
//
//  Created by david on 14/8/8.
//
//

#import "CityViewController.h"
#import "HotCityModel.h"
@interface CityViewController (){

    IBOutlet UIButton         *_locationButton;
    IBOutlet ITTPullTableView *_provincesTableView;
    IBOutlet ITTPullTableView *_citysTableView;
    IBOutlet UIButton         *_selectBtn;
    //热门城市按钮
    IBOutlet UIButton         *_btn1;
    IBOutlet UIButton         *_btn2;
    IBOutlet UIButton         *_btn3;
    IBOutlet UIButton         *_btn4;
    IBOutlet UIButton         *_btn5;
    IBOutlet UIButton         *_btn6;
    IBOutlet UILabel          *_currentCityLabel;
    IBOutlet UIImageView      *_locationImageView;
    CLLocationManager         *_myLocationManager;
    CLLocation                *_myLocation;
    
    NSArray                   *_provincesDataArray;
//    NSArray *_hotArr;
//    NSArray *_hotSonArr;
    NSMutableArray            *_citysDataArray;
    NSMutableArray            *_hotCityArray;
    NSMutableArray            *_provincesNameDataArray; //9.20
    NSInteger                 _provinceRow;//9.20
    NSInteger                 _cityRow;//9.20
//    NSMutableArray *_hotCitySonArray;
    NSIndexPath              *_firstSelectIndexPath;
    NSIndexPath              *_firstCitySelectIndexPath;
    NSIndexPath              *_secondSelectIndexPath;
    NSIndexPath              *_didDeselect;
    NSString                 *_administrativeArea;
    BOOL                     _isReload;
}

@end

@implementation CityViewController

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
    //GPS定位
    if([CLLocationManager locationServicesEnabled])
    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"酒知道" message:@"酒知道要使用你当前的位置" delegate:self cancelButtonTitle:@"不允许" otherButtonTitles:@"好", nil];
//        alert.tag = 1;
//        [alert show];
        [self startLocation];

    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启酒知道)" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
      //  [UIAlertView popupAlertByDelegate:nil title:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启酒知道)"];
    }
     
    _hotCityArray = [[NSMutableArray alloc]init];
    [self getRequest];
    _secondSelectIndexPath = nil;
    _firstSelectIndexPath = nil;
//    _hotArr = @[@"北京",@"上海",@"广东",@"广东",@"江苏",@"浙江"];
//    _hotSonArr = @[@"广州",@"深圳",@"南京",@"杭州"];
             //北京 上海 广州 深圳 南京 杭州
//    _hotCityArray = [[NSMutableArray alloc]init];
//    _hotCitySonArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    _provincesDataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    
    //9.20dd
    
    NSArray *initArray = [_city componentsSeparatedByString:@"#"];
   // NSLog(@"iniiniiniin%@",initArray.firstObject);
    _provincesNameDataArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _provincesDataArray.count; i++) {
        NSDictionary *dic = _provincesDataArray[i];
        NSString *provincesName = [dic objectForKey:@"state"];
        [_provincesNameDataArray addObject:provincesName];
    }
    NSString *privinceName = (NSString *)initArray.firstObject;
    
    if ([_provincesNameDataArray indexOfObject:privinceName] != NSNotFound) {
        
        _provinceRow = [_provincesNameDataArray indexOfObject:privinceName];
        
    }
    //9.20dd
    
    
    NSDictionary *dic = _provincesDataArray[_provinceRow];
    _citysDataArray = [NSMutableArray arrayWithArray:[dic valueForKey:@"cities"]];
    
    //9.20
    NSString *cityName = (NSString *)initArray.lastObject;
    if ([_citysDataArray indexOfObject:cityName] != NSNotFound) {
        
        _cityRow = [_citysDataArray indexOfObject:cityName];
    }
    
    //9.20
    _citysTableView.delegate = self;
    _citysTableView.dataSource = self;
    _provincesTableView.delegate = self;
    _provincesTableView.dataSource = self;
    [_provincesTableView setLoadMoreViewHidden:YES];
    [_provincesTableView setRefreshViewHidden:YES];
    [_citysTableView setLoadMoreViewHidden:YES];
    [_citysTableView setRefreshViewHidden:YES];
    
    NSIndexPath *first = [NSIndexPath
                          indexPathForRow:_provinceRow inSection:0];
    NSIndexPath *firstCity = [NSIndexPath
                           indexPathForRow:_cityRow inSection:0];
    _firstSelectIndexPath = first;
    _secondSelectIndexPath = first;
    _firstCitySelectIndexPath = firstCity;
    
//    _didDeselect = first;
    [_provincesTableView selectRowAtIndexPath:first animated:NO scrollPosition:UITableViewScrollPositionTop];
     [_citysTableView selectRowAtIndexPath:firstCity animated:NO scrollPosition:UITableViewScrollPositionTop];
    UITableViewCell *tmpCell = [_provincesTableView cellForRowAtIndexPath:first];
    tmpCell.textLabel.textColor = [UIColor colorWithRed:119.0f/225.0f green:25.5f/225.0f blue:71.0f/225.0f alpha:1];
    _locationImageView.hidden = YES;
    _locationButton.enabled = YES;
    [self rotationImage];
    
    
    
}

#pragma mark - alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else if (buttonIndex == 1){
     //   [self startLocation];
//        _locationImageView.hidden = NO;
//        _locationButton.enabled = NO;
//        [_locationButton setTitle:@"正在定位您所在的城市" forState:UIControlStateNormal];
//     //   _locationButton.left = 60;
//        _myLocationManager = [[CLLocationManager alloc]init];
//        _myLocationManager.delegate = self;
//       // _myLocationManager.purpose = @"酒知道要使用你当前的位置";
//        //选择定位的方式为最优的状态，他又四种方式在文档中能查到
//        _myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
//        //发生事件的最小距离间隔
//        _myLocationManager.distanceFilter = 1000.0f;
//        [_myLocationManager startUpdatingLocation];
    }
}

#pragma mark - startLocation

- (void)startLocation
{
//    _locationButton.enabled = NO;
//    [_locationButton setTitle:@"正在定位您所在的城市" forState:UIControlStateNormal];
    //   _locationButton.left = 60;
    _myLocationManager = [[CLLocationManager alloc]init];
    _myLocationManager.delegate = self;
    // _myLocationManager.purpose = @"酒知道要使用你当前的位置";
    //选择定位的方式为最优的状态，他又四种方式在文档中能查到
    _myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //发生事件的最小距离间隔
    _myLocationManager.distanceFilter = 1000.0f;
    [_myLocationManager startUpdatingLocation];
}

//- (void)startUpdatingLocation
//{
//    
//}

#pragma mark - get Request
-(void)getRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

   // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    [HotCityRequest requestWithParameters:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
        if ([request isSuccess]) {

            _hotCityArray = request.handleredResult[@"dataArray"];
            for (int i = 0; i < _hotCityArray.count; i++) {
                HotCityModel *model = _hotCityArray[i];
                switch (i) {
                    case 0:
                        if ([_city rangeOfString:model.cityCityName].location !=NSNotFound && _city != NULL) {
                            _btn1.selected = YES;
                        }
                        [_btn1 setTitle:model.cityCityName forState:UIControlStateNormal];
                        [_btn1 setTitle:model.cityCityName forState:UIControlStateSelected];
                        _btn1.hidden = NO;
                        break;
                    case 1:
                        if ([_city rangeOfString:model.cityCityName].location !=NSNotFound && _city != NULL) {
                            _btn2.selected = YES;
                        }
                        [_btn2 setTitle:model.cityCityName forState:UIControlStateNormal];
                        [_btn2 setTitle:model.cityCityName forState:UIControlStateSelected];
                        _btn2.hidden = NO;
                        break;
                    case 2:
                        if ([_city rangeOfString:model.cityCityName].location !=NSNotFound && _city != NULL) {
                            _btn3.selected = YES;
                        }
                        [_btn3 setTitle:model.cityCityName forState:UIControlStateNormal];
                        [_btn3 setTitle:model.cityCityName forState:UIControlStateSelected];
                        _btn3.hidden = NO;
                        break;
                    case 3:
                        if ([_city rangeOfString:model.cityCityName].location !=NSNotFound && _city != NULL) {
                            _btn4.selected = YES;
                        }
                        [_btn4 setTitle:model.cityCityName forState:UIControlStateNormal];
                        [_btn4 setTitle:model.cityCityName forState:UIControlStateSelected];
                        _btn4.hidden = NO;
                        break;
                    case 4:
                        if ([_city rangeOfString:model.cityCityName].location !=NSNotFound && _city != NULL) {
                            _btn5.selected = YES;
                        }
                        [_btn5 setTitle:model.cityCityName forState:UIControlStateNormal];
                        [_btn5 setTitle:model.cityCityName forState:UIControlStateSelected];
                        _btn5.hidden = NO;
                        break;
                    default:
                        if ([_city rangeOfString:model.cityCityName].location !=NSNotFound && _city != NULL) {
                            _btn6.selected = YES;
                        }
                        [_btn6 setTitle:model.cityCityName forState:UIControlStateNormal];
                        [_btn6 setTitle:model.cityCityName forState:UIControlStateSelected];
                        _btn6.hidden = NO;
                        break;
                }
           //     NSLog(@"  cityCityName%@",model.cityCityName);
                
            }
        }
        
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 100) {
        
        return _provincesDataArray.count;
        
    } else {
        
        return _citysDataArray.count;
    
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    if (tableView.tag == 100) {
        
        static NSString *cellId = @"provincesCellId";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        NSDictionary *dic = _provincesDataArray[indexPath.row];
        NSString *provincesName = [dic valueForKey:@"state"];
//        if ([_hotArr containsObject:provincesName]) {
//            [_hotCityArray addObject:provincesName];
//            [_hotCityArray addObject:indexPath];
//        }
        cell.textLabel.text = provincesName;
        if (_secondSelectIndexPath.row != indexPath.row && _firstSelectIndexPath != nil) {
            
            cell.textLabel.textColor = [UIColor blackColor];
            
        } else if(_secondSelectIndexPath.row == indexPath.row && _firstSelectIndexPath != nil){
        
             cell.textLabel.textColor = [UIColor colorWithRed:119.0f/225.0f green:25.5f/225.0f blue:71.0f/225.0f alpha:1];
            
        }
        
    } else {
    
        static NSString *cellId = @"citysCellId";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.backgroundColor = [UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;

            
        }
        NSString* cityName = _citysDataArray[indexPath.row];
        cell.textLabel.text = cityName;
//        if ([_hotSonArr containsObject:cityName]) {
//            
//            [_hotCitySonArray addObject:cityName];
//            [_hotCitySonArray addObject:indexPath];
//            
//        }
//        if ((_secondSelectIndexPath.row != indexPath.row && _secondSelectIndexPath != nil)||(_isReload == YES&&_secondSelectIndexPath == nil)) {
//            
//            cell.textLabel.textColor = [UIColor blackColor];
//            
//        } else if(_secondSelectIndexPath.row == indexPath.row && _secondSelectIndexPath != nil){
//        
//             cell.textLabel.textColor = [UIColor colorWithRed:119.0f/225.0f green:25.5f/225.0f blue:71.0f/225.0f alpha:1];
//            
//        }
        if (_firstCitySelectIndexPath.row == indexPath.row && _secondSelectIndexPath.row == _firstSelectIndexPath.row) {
            
            cell.textLabel.textColor = [UIColor colorWithRed:119.0f/225.0f green:25.5f/225.0f blue:71.0f/225.0f alpha:1];

        } else {
            
            cell.textLabel.textColor = [UIColor blackColor];

        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 100) {
        _isReload = YES;
        _secondSelectIndexPath = nil;
        [_citysDataArray removeAllObjects];
        NSDictionary *dic = _provincesDataArray[indexPath.row];
        [_citysDataArray addObjectsFromArray:[dic valueForKey:@"cities"]];
        [_citysTableView reloadData];
 //       _firstSelectIndexPath = indexPath;
       UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor colorWithRed:119.0f/225.0f green:25.5f/225.0f blue:71.0f/225.0f alpha:1];
        
        _secondSelectIndexPath = indexPath;
        
    } else {
    
        NSDictionary *dic = _provincesDataArray[_secondSelectIndexPath.row];
        NSString *provincesName = [dic valueForKey:@"state"];
        
        _secondSelectIndexPath = indexPath;
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor colorWithRed:119.0f/225.0f green:25.5f/225.0f blue:71.0f/225.0f alpha:1];
        NSString *cityName = cell.textLabel.text;
      //  NSLog(@"cityName %@",cityName);
        if ([provincesName isEqualToString:cityName]) {
            [_delegate selectedCity:[NSString stringWithFormat:@"%@#%@",cityName,cityName]];
        }else{
        [_delegate selectedCity:[NSString stringWithFormat:@"%@#%@",provincesName,cityName]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];
    
}
-(IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)selectBtn:(id)sender
{
    [_selectBtn setSelected:NO];
    UIButton *btn = (UIButton *)sender;
    _selectBtn = btn;
    [_selectBtn setSelected:YES];
    
  //  [_delegate selectedCity:btn.titleLabel.text];
//    if (_hotCityArray.count ) {
//        <#statements#>
//    }
    HotCityModel *model;
    NSDictionary *dic ;
    if (_hotCityArray.count>btn.tag-101) {
        model = _hotCityArray[btn.tag-101];
    }
    if (_provincesDataArray.count>model.cityCountryId.integerValue-1) {
        dic = _provincesDataArray[model.cityCountryId.integerValue-1];
    }
    NSString *provincesName = [dic valueForKey:@"state"];
    
    if ([provincesName isEqualToString:model.cityCityName]) {
        [_delegate selectedCity:[NSString stringWithFormat:@"%@#%@",model.cityCityName, model.cityCityName]];
    } else {
    [_delegate selectedCity:[NSString stringWithFormat:@"%@#%@",provincesName, model.cityCityName]];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
 //   NSInteger index;
 //   NSInteger indexSon;
    switch (btn.tag) {
        case 101:
        {
        
            //北京
//            index = [_hotCityArray indexOfObject:@"北京"];
//            if (index != NSNotFound) {
//                
//                [self locationTableView:index isCity:NO];
//                
//            }
            
        }
            break;
        case 102:
        {
         
            //上海
//            index = [_hotCityArray indexOfObject:@"上海"];
//            if (index != NSNotFound) {
//                
//                [self locationTableView:index isCity:NO];
//                
//            }
        }
            break;
        case 103:
        {
            
            //广州
//            index = [_hotCityArray indexOfObject:@"广东"];
//            if (index != NSNotFound) {
//                
//                [self locationTableView:index isCity:NO];
//                
//            }
//            indexSon = [_hotCitySonArray indexOfObject:@"广州"];
//            if (indexSon != NSNotFound) {
//                [self locationTableView:indexSon isCity:YES];
//            }
        }
            break;
        case 104:
        {
            
            //深圳
//            index = [_hotCityArray indexOfObject:@"广东"];
//            if (index != NSNotFound) {
//                
//                [self locationTableView:index isCity:NO];
//                
//            }
//            indexSon = [_hotCitySonArray indexOfObject:@"深圳"];
//            if (indexSon != NSNotFound) {
//                [self locationTableView:indexSon isCity:YES];
//            }
        }
            break;
        case 105:
        {
            
            //南京
//            index = [_hotCityArray indexOfObject:@"江苏"];
//            if (index != NSNotFound) {
//                
//                [self locationTableView:index isCity:NO];
//                
//            }
//            indexSon = [_hotCitySonArray indexOfObject:@"南京"];
//            if (indexSon != NSNotFound) {
//                [self locationTableView:indexSon isCity:YES];
//            }
        }
            break;
        default:
        {
            
            //杭州
//            index = [_hotCityArray indexOfObject:@"浙江"];
//            if (index != NSNotFound) {
//                
//                [self locationTableView:index isCity:NO];
//                
//            }
//            indexSon = [_hotCitySonArray indexOfObject:@"杭州"];
//            if (indexSon != NSNotFound) {
//                [self locationTableView:indexSon isCity:YES];
//            }
        }
            break;
    }
    
}
/*
-(void)locationTableView:(NSInteger)index isCity:(BOOL)city
{
    if (city == NO) {
        //直辖市
        NSIndexPath *indexPath = _hotCityArray[index+1];
        [_provincesTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:_provincesTableView didDeselectRowAtIndexPath:_didDeselect];
        [self tableView:_provincesTableView didSelectRowAtIndexPath:indexPath];
        
        _didDeselect = indexPath;
    } else {
    //城市
        NSIndexPath *indexPath = _hotCitySonArray[index+1];
        [_citysTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:_citysTableView didDeselectRowAtIndexPath:_didDeselect];
        [self tableView:_citysTableView didSelectRowAtIndexPath:indexPath];
        
        _didDeselect = indexPath;
    }
   
}
*/
#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
 //   [self.navigationController popViewControllerAnimated:YES];

    _locationImageView.hidden = NO;
    _locationButton.enabled = NO;
    [_locationButton setTitle:@"正在定位您所在的城市" forState:UIControlStateNormal];
   // CLLocation *locatin = [[CLLocation alloc]initWithLatitude:34.46 longitude:114.21];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
  /*
   name; // eg. Apple Inc.
   thoroughfare; // street address, eg. 1 Infinite Loop
   subThoroughfare; // eg. 1
   locality; // city, eg. Cupertino
   subLocality; // neighborhood, common name, eg. Mission District
   administrativeArea; // state, eg. CA
   subAdministrativeArea; // county, eg. Santa Clara
   postalCode; // zip code, eg. 95014
   ISOcountryCode; // eg. US
   country; // eg. United States
   inlandWater; // eg. Lake Tahoe
   ocean; // eg. Pacific Ocean
   */
            CLPlacemark *placemark = [array objectAtIndex:0];
            
     //       NSString *name = placemark.name;
            //中国北京市海淀区海淀街道人民大学海淀南路84号
     
       //     NSString *thoroughfare = placemark.thoroughfare;
            //海淀南路
            
        //    NSString *subThoroughfare = placemark.subThoroughfare;
            //84号
            
            NSString *locality = placemark.locality;
            //null
            
        //    NSString *subLocality = placemark.subLocality;
            //海淀区
            
            _currentCityLabel.text = placemark.administrativeArea;
            //北京市
            NSString *administrativeArea =  placemark.administrativeArea;
         //   NSString *subAdministrativeArea = placemark.subAdministrativeArea;
            //null
         //   NSString *postalCode = placemark.postalCode;
            //null
       //     NSString *ISOcountryCode = placemark.ISOcountryCode;
            //CN
       //     NSString *country = placemark.country;
            //中国 p
       //     NSString *inlandWater = placemark.inlandWater;
            //null
       //     NSString *ocean = placemark.ocean;
            //null
            
          //  NSString *message = [NSString stringWithFormat:@"placemark:%@ name:%@ thoroughfare:%@ subThoroughfare:%@ locality:%@ subLocality:%@ administrativeArea:%@ subAdministrativeArea:%@ postalCode:%@ ISOcountryCode:%@ country:%@ inlandWater:%@ ocean:%@  ",placemark,name,thoroughfare,subThoroughfare,locality,subLocality,administrativeArea,subAdministrativeArea,postalCode,ISOcountryCode,country,inlandWater,ocean];
          //  NSLog(@"定位定位--%@",message);
          //  [UIAlertView popupAlertByDelegate:self title:@"123" message:message];
            [_myLocationManager stopUpdatingLocation];
            _locationImageView.hidden = YES;
            _locationButton.enabled = YES;

            [_locationButton setTitle:@"GPS定位" forState:UIControlStateNormal];
            _locationButton.enabled = NO;

            _locationButton.left = 60;
            administrativeArea = [administrativeArea substringToIndex:administrativeArea.length-1];
            if (locality == nil) {
                [_delegate selectedCity:[NSString stringWithFormat:@"%@#%@",administrativeArea, administrativeArea]];
              //  [self.navigationController popViewControllerAnimated:YES];
            } else{
                locality = [locality substringToIndex:locality.length-1];
                [_delegate selectedCity:[NSString stringWithFormat:@"%@#%@",administrativeArea, locality]];
             //   [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    [self performSelector:@selector(willBack) withObject:self afterDelay:2];
}

- (void)willBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启酒知道)" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    } else {
    [_locationButton setTitle:@"定位失败, 请点击重试" forState:UIControlStateNormal];
    _locationButton.enabled = YES;
    _locationImageView.hidden = YES;
    _locationButton.left = 13;
    }
}

- (void)rotationImage
{

    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INTMAX_MAX;
    [_locationImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - buttonClick

- (IBAction)locationButton:(id)sender
{
    [self startLocation];

}

@end
