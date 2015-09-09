//
//  BrandViewController.m
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "BrandViewController.h"
#import "BrandTableViewCell.h"
#import "BrandModel.h"
#import "WineFactoryViewController.h"
#import "PKRevealController.h"

@interface BrandViewController (){
    IBOutlet ITTPullTableView   *_table;
    NSMutableArray              *_dataArray;
    NSInteger                    _page;
    HaierDataCacheManager       *_cache;

}

@end

@implementation BrandViewController

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
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    _page = 1;
    _dataArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    _cache = [HaierDataCacheManager sharedManager];
    if ([_cache isHaveDataWithKey:@"BrandViewController"]){
        
        [_dataArray addObjectsFromArray:[_cache getDataWithKey:@"BrandViewController"]];
    }
    [self brandRequest];
    _table.delegate = self;
    _table.dataSource = self;
    _table.pullDelegate = self;
  //  [_table setRefreshViewHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - request method
-(void)brandRequest
{
//    LoadingView *loadingView = [LoadingView loadFromXib];
//    
//    loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
//    
//    [self.view addSubview:loadingView];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (_table.pullTableIsLoadingMore == NO) {
        _page = 1;
    }
    NSString *_pageStr = [NSString stringWithFormat:@"%d",_page];
    [parameters setValue:_pageStr forKey:@"page"];
    
    [BrandRequest requestWithParameters:parameters
                               withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                   if ([request isSuccess]) {
                                //       [loadingView removeFromSuperview];
                                     //  NSLog(@"999999%@",request.handleredResult);
                                       
                                       NSString *i = (NSString *)request.handleredResult[@"data"][@"count"];
                                       if (i.integerValue < 10) {
                                           [_table setLoadMoreViewHidden:YES];
                                       }
                                       if (_table.pullTableIsLoadingMore == NO) {
                                           [_dataArray removeAllObjects];
                                       }
                                       [_dataArray addObjectsFromArray:request.handleredResult[@"dataArray"]];
                                       
                                       if (_page == 1) {
                                           
                                           [_cache addData:_dataArray WithKey:@"BrandViewController"];
                                       }
                                       
                                   } else {
                                   
                                       [_table setLoadMoreViewHidden:YES];
                                   }
                                   _table.pullTableIsLoadingMore = NO;
                                   _table.pullTableIsRefreshing = NO;
                                   [_table reloadData];
                                   
                               } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                          //         [loadingView removeFromSuperview];
                                   _table.pullTableIsLoadingMore = NO;
                                   _table.pullTableIsRefreshing = NO;
                                 //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                   //假数据
//                                   BrandModel *model = [[BrandModel alloc]init];
//                                   model.brandName = @"酒庄";
//                                   model.brandCity = @"地址";
//                                   model.brandCountry = @"产区";
//                                   for (int i = 0; i < 6; i++) {
//                                       [_dataArray addObject:model];
//                                   }
//                                   [_table reloadData];
                                   //假数据
                                   
                               }];
}
#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"BrandTableViewCellId";
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [BrandTableViewCell cellFromNib];
        
        //666666
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:218.0/255.f green:218.0/255.f blue:218.0/255.f alpha:1];
    }
    BrandModel *model = _dataArray[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    BrandTableViewCell *selectCell = (BrandTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    selectCell.contentView.backgroundColor = [UIColor colorWithRed:218/255.0f green:218/255.0f blue:218/255.0f alpha:1];
    */
    WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
    BrandModel *model = _dataArray[indexPath.row];
    
    wfc.WineFactoryID = model.brandId;
    wfc.factoryName = model.brandName;
    wfc.type = @"1";
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:wfc animated:YES];
    
}

#pragma mark - pulltableview loadmore delegate
- (void)pullTableViewDidTriggerRefresh:(ITTPullTableView*)pullTableView
{
    
    [_table setLoadMoreViewHidden:NO];
    [self brandRequest];
    
}

- (void)pullTableViewDidTriggerLoadMore:(ITTPullTableView*)pullTableView
{
    _page++;
    [self brandRequest];
}
@end
