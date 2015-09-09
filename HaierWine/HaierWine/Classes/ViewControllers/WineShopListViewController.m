//
//  WineShopListViewController.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import "WineShopListViewController.h"
#import "WineShopListTableViewCell.h"
#import "WineShopDetailViewController.h"
#import "WebViewController.h"
#import "WineShop.h"
@interface WineShopListViewController ()
{
    
    IBOutlet UILabel      *_titleLabel;
    IBOutlet UILabel      *_location;
    IBOutlet UITableView  *_wineShopTableView;
    

    CLLocationManager     *_myLocationManager;
    CLLocation            *_myLocation;
    NSArray               *_dataArray;
    NSArray               *_ascendArray;
    NSArray               *_deascendArray;
    WineShop              *_firstShop;
    BOOL                  _isAscend;
}
@end

@implementation WineShopListViewController

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
    _titleLabel.text = _wineName;
    _firstShop = [[WineShop alloc]init];
    
    //GPS定位
    if([CLLocationManager locationServicesEnabled])
    {
        [self startLocation];

    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启酒知道)" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        //  [UIAlertView popupAlertByDelegate:nil title:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启酒知道)"];
    }

//_ascendArray
    
    _isAscend = YES;

    [self getWineshopRequest];
}

#pragma mark - alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else if (buttonIndex == 1){
    }
}

#pragma mark - getWineshopRequest

- (void)getWineshopRequest
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_wineID forKey:@"goodsId"];
    [WineShopRequest requestWithParameters:parameters withIndicatorView:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        _ascendArray = [self comparisonPriceWithArray:request.handleredResult[@"WineShop"]];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (int i = 0; i<_ascendArray.count; i++) {
        //    NSLog(@"倒序倒序--%@",[_ascendArray objectAtIndex:_ascendArray.count]);
            [temp insertObject:[_ascendArray objectAtIndex:i] atIndex:0];
            //  [temp addObject:[_ascendArray objectAtIndex:_ascendArray.count - i]];
        }
        _deascendArray = temp;
       // NSLog(@"_dataArray--%@",_ascendArray);
       // NSLog(@"_dataArray--%@",_deascendArray);
        _dataArray = _deascendArray;
        [_wineShopTableView reloadData];
    }];
}

- (NSArray *)comparisonPriceWithArray:(NSArray *)array
{
    NSArray *array1 = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WineShop *shop1 = obj1;
        WineShop *shop2 = obj2;
        
        NSComparisonResult result = [[NSNumber numberWithInt:[shop1.winePrice intValue]] compare:[NSNumber numberWithInt:[shop2.winePrice intValue]]];
        return result;
    }];

   // NSLog(@"%@",_deascendArray);
    return array1;
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    WineShopListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell){
        cell = [WineShopListTableViewCell cellFromNib];
    }
    //  cell.lookLabel.hidden = NO;
    if (indexPath.row == 0) {
        cell.lookLabel.hidden = NO;
        cell.winePrice.hidden = YES;
        cell.winepriceDtail.hidden = YES;
      //  cell.lookLabel.backgroundColor = [UIColor whiteColor];
    } else
    {
        WineShop *shop = [_dataArray objectAtIndex:indexPath.row-1];
        cell.wineShopName.text = shop.wineShopName;
        NSRange range = [shop.winePrice rangeOfString:@"."];
        NSString *price;
        if (range.location !=0) {
            price =[shop.winePrice substringToIndex:range.location];
        }
        cell.winePrice.text = [NSString stringWithFormat:@"¥ %@",price];
        cell.lookLabel.hidden = YES;
        cell.winePrice.hidden = NO;
        cell.winepriceDtail.hidden = NO;

    }
    return cell;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ((WineShopListTableViewCell*)cell).lookLabel.hidden = NO;
    } else {
        ((WineShopListTableViewCell*)cell).lookLabel.hidden = YES;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WebViewController *web = [[WebViewController alloc]init];
        web.type = 2;
        [self.navigationController pushViewController:web animated:YES];
    } else {
    WineShop *shop = [_dataArray objectAtIndex:indexPath.row - 1];
    WineShopDetailViewController *wdv = [[WineShopDetailViewController alloc]init];
    wdv.shopId = shop.wineShopId;
    [self.navigationController pushViewController:wdv animated:YES];
    }
}

#pragma mark - PrinceButton

- (IBAction)princeButtonClick:(id)sender
{

    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        _dataArray = _ascendArray;

        [_wineShopTableView reloadData];
        
    } else {
        _dataArray = _deascendArray;

        [_wineShopTableView reloadData];
    }

    _isAscend = !_isAscend;
}

#pragma mark - back

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            _location.text = placemark.administrativeArea;
            [_myLocationManager stopUpdatingLocation];
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启酒知道)" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
        
    }
}

- (void)startLocation
{
    _myLocationManager = [[CLLocationManager alloc]init];
    _myLocationManager.delegate = self;
    // _myLocationManager.purpose = @"酒知道要使用你当前的位置";
    //选择定位的方式为最优的状态，他又四种方式在文档中能查到
    _myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //发生事件的最小距离间隔
    _myLocationManager.distanceFilter = 1000.0f;
    [_myLocationManager startUpdatingLocation];
}

- (IBAction)locationButton:(id)sender
{
    [self startLocation];
}


@end
