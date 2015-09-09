//
//  FamousParkWineViewController.m
//  HaierWine
//
//  Created by david on 14/7/10.
//
//

#import "FamousParkWineViewController.h"
#import "WineFactoryViewController.h"
#import "PKRevealController.h"
@interface FamousParkWineViewController (){
    NSMutableArray              *_dataArray;
    NSInteger                    _page;
    
    IBOutlet ITTPullTableView   *_table;
    HaierDataCacheManager       *_cache;

}

@end

@implementation FamousParkWineViewController

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
    
    // Do any additional setup after loading the view from its nib.
    _dataArray = [[NSMutableArray alloc]init];
    _table.delegate = self;
    _table.dataSource = self;
    _table.pullDelegate = self;
    
    _page = 1;
    _cache = [HaierDataCacheManager sharedManager];
    if ([_cache isHaveDataWithKey:@"FamousParkWineViewController"]){
        
        [_dataArray addObjectsFromArray:[_cache getDataWithKey:@"FamousParkWineViewController"]];
    }
    [self famousParkWineRequest];

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
-(void)famousParkWineRequest{
    
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
    
    
   [FamousParkWineRequest requestWithParameters:parameters
withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
    if ([request isSuccess]) {
   //     [loadingView removeFromSuperview];
        NSString *i = (NSString *)request.handleredResult[@"data"][@"count"];
        if (i.integerValue < 10) {
            [_table setLoadMoreViewHidden:YES];
        }
        if (_table.pullTableIsLoadingMore == NO) {
            [_dataArray removeAllObjects];
        }
        
        [_dataArray addObjectsFromArray:request.handleredResult[@"dataArray"]];
        
        if (_page == 1) {
            
            [_cache addData:_dataArray WithKey:@"FamousParkWineViewController"];
        }
    } else {
        
    [_table setLoadMoreViewHidden:YES];
        
    }
    
    
    _table.pullTableIsLoadingMore = NO;
    _table.pullTableIsRefreshing = NO;

       [_table reloadData];
    
} onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
 //   [loadingView removeFromSuperview];
    _table.pullTableIsLoadingMore = NO;
    _table.pullTableIsRefreshing = NO;
   // [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
    //假数据
//    FamousParkWineModel *model = [[FamousParkWineModel alloc]init];
//    model.parkName = @"酒庄";
//    model.parkAddress = @"地址";
//    model.parkLevel = @"等级";
//    for (int i = 0; i < 6; i++) {
//        [_dataArray addObject:model];
//    }
//    [_table reloadData];
    //假数据

}];
}
#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellId = @"FamousParkWineTableViewCellId";
    FamousParkWineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [FamousParkWineTableViewCell cellFromNib];
        
        //666666
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:218.0/255.f green:218.0/255.f blue:218.0/255.f alpha:1];
         
    }
    FamousParkWineModel * model = _dataArray[indexPath.row];
    [cell fillCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    FamousParkWineTableViewCell *selectCell = (FamousParkWineTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    selectCell.contentView.backgroundColor = [UIColor colorWithRed:218/255.0f green:218/255.0f blue:218/255.0f alpha:1];
    */
    WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
    FamousParkWineModel * model = _dataArray[indexPath.row];
    wfc.WineFactoryID = model.parkId;
    wfc.factoryName = model.parkName;
    wfc.type = @"0";
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:wfc animated:YES];
}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    FamousParkWineTableViewCell *selectCell = (FamousParkWineTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    selectCell.contentView.backgroundColor = [UIColor whiteColor];
//}
#pragma mark - pulltableview loadmore delegate
- (void)pullTableViewDidTriggerRefresh:(ITTPullTableView*)pullTableView
{
    
    [_table setLoadMoreViewHidden:NO];
    [self famousParkWineRequest];
    
}

- (void)pullTableViewDidTriggerLoadMore:(ITTPullTableView*)pullTableView
{
    _page++;
    [self famousParkWineRequest];
}
@end
