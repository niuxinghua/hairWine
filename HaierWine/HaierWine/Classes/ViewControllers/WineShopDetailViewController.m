//
//  WineShopDetailViewController.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import "WineShopDetailViewController.h"
#import "ITTImageView.h"
#import "WineShopListTableViewCell.h"
#import "BuyWineViewController.h"
#import "WebViewController.h"
#import "HeadView.h"
#import "ShopDetail.h"
#import "DetailWineViewController.h"
#import "winePrice.h"
@interface WineShopDetailViewController ()
{
    IBOutlet ITTImageView  *_wineShopImageView;
    IBOutlet UILabel       *_wineShopName;
    IBOutlet UILabel       *_wineShopAddress;
    IBOutlet UILabel       *_wineShopTell;
    IBOutlet UILabel       *_wineDistribution;
    IBOutlet UITableView   *_wineTableView;
    NSArray                *_dataArray;
    ShopDetail             *_shopDetail;
    NSArray                *_nameArray;
    
}

@end

@implementation WineShopDetailViewController

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
    [self getWineshopRequest];
}

#pragma mark - getWineshopRequest

- (void)getWineshopRequest
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_shopId forKey:@"merchantId"];
   // NSLog(@"parameters--%@",parameters);
    [WineShopDetailRequest requestWithParameters:parameters withIndicatorView:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        _shopDetail = request.handleredResult[@"ShopDetail"];
        _dataArray = _shopDetail.shopList;
        _nameArray = _shopDetail.wineNameArray;
        [_wineShopImageView loadImage:_shopDetail.shopLogo placeHolder:[UIImage imageNamed:@"100x100"]];
        _wineShopName.text = _shopDetail.shopName;
        _wineShopAddress.text = _shopDetail.shopAddress;
        _wineShopTell.text = _shopDetail.shopPhone;
        if ([_shopDetail.shopDisservice isEqualToString:@"Y"]) {
            _wineDistribution.text = @"提供配送服务";
        } else if ([_shopDetail.shopDisservice isEqualToString:@"N"]){
            _wineDistribution.text = @"不提供配送服务";
        }
        [_wineTableView reloadData];
      //   NSLog(@"_dataArray--%@",_dataArray);
    }];
}

#pragma mark - tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    WineShopListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil == cell){
        cell = [WineShopListTableViewCell cellFromNib];
    }
    winePrice *winePrice = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
   // NSLog(@"----%@",[_dataArray objectAtIndex:indexPath.section]);
    cell.wineShopName.text = winePrice.wineName;
    if(winePrice.winePrice.length !=0){
        NSRange range = [winePrice.winePrice rangeOfString:@"."];
        NSString *price = [winePrice.winePrice substringToIndex:range.location];
        cell.winePrice.text = [NSString stringWithFormat:@"¥ %@",price];
    }


    return cell;
}

#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    winePrice *winePrice = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
    dvc.wineID = winePrice.wineId;
    [self.navigationController pushViewController:dvc animated:YES];

    //WebViewController *bvc = [[WebViewController alloc]init];
   // [self.navigationController pushViewController:bvc animated:YES];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"干红葡萄酒";
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView loadFromXib];
   // headView.wineClass.text = [_shopDetail.wineNameArray objectAtIndex:section];
    headView.wineClass.text = [_nameArray objectAtIndex:section];
    return headView;
}

#pragma mark - back

- (IBAction)backbutton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma wineShopTell

- (IBAction)wineShopTellButton:(id)sender
{
//    [_application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_applicationTellButton.titleLabel.text]]];
    NSString *urlStr = [NSString stringWithFormat:@"tel://%@",_wineShopTell.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
