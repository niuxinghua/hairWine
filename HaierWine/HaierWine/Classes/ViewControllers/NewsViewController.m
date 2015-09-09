//
//  NewsViewController.m
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "DetailViewController.h"
#import "PKRevealController.h"
#import "MainViewController.h"
#import "ArticleReadCach.h"

@interface NewsViewController (){
    
    IBOutlet ITTPullTableView   *_tableView;
    NSInteger                    _page;
    NSMutableArray              *_dataArray;
    HaierDataCacheManager       *_cache;
    
}

@end

@implementation NewsViewController

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
    //cache
    
    _page = 1;
    _dataArray = [[NSMutableArray alloc]init];
    
    _cache = [HaierDataCacheManager sharedManager];
    if ([_cache isHaveDataWithKey:@"NewsViewController"]){
        
        [_dataArray addObjectsFromArray:[_cache getDataWithKey:@"NewsViewController"]];
    }
    
    
    [self newsRequestMethod];
    // Do any additional setup after loading the view from its nib.
    //    _dataArray = [[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.pullDelegate = self;
  //  [_tableView setLoadMoreViewHidden:YES];
  //  [_tableView setRefreshViewHidden:YES];
    
    //9.19dd
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - tabelview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"NewsTableViewCellId";
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [NewsTableViewCell cellFromNib];
        //666666
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:218.0/255.f green:218.0/255.f blue:218.0/255.f alpha:1];
        
    }
    
    NewsModel *model = _dataArray[indexPath.row];
    [cell fillCellWithModel:model];
    if (model.isChecked == YES) {
        
        cell.newsTitleLabel.textColor = [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:1];
        
    } else {
    
        cell.newsTitleLabel.textColor = [UIColor blackColor];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //改变cell中颜色
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.newsTitleLabel.textColor = [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:1];
    NewsModel *model = _dataArray[indexPath.row];
    model.isChecked = YES;
    [ArticleReadCach addReadedNews:model.newsId withType:NewsArticle];
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    detailVc.type = NewsDetailType;
    detailVc.newsId = model.newsId;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}
#pragma mark - pulltableview delegate
- (void)pullTableViewDidTriggerRefresh:(ITTPullTableView*)pullTableView
{
        [_tableView setLoadMoreViewHidden:NO];
        [self newsRequestMethod];
    
}
- (void)pullTableViewDidTriggerLoadMore:(ITTPullTableView*)pullTableView
{
    
    _page++;
    [self newsRequestMethod];
    
}
#pragma mark - request method
-(void)newsRequestMethod
{
//    LoadingView *loadingView = [LoadingView loadFromXib];
//    
//    loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
//    
//    [self.view addSubview:loadingView];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if (_tableView.pullTableIsLoadingMore == NO) {
        
        
        _page = 1;
        
    }
    NSString *_pageStr = [NSString stringWithFormat:@"%d",_page];
    [parameters setValue:_pageStr forKey:@"page"];
    
    [NewsRequest requestWithParameters:parameters withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([request isSuccess]) {
     //       [loadingView removeFromSuperview];
            NSString *i = (NSString *)request.handleredResult[@"data"][@"count"];
            
           // NSLog(@"integerValueintegerValueintegerValue %@",i);
            if (i.integerValue < 10) {
                
                [_tableView setLoadMoreViewHidden:YES];
                
            }
            
            if (_tableView.pullTableIsLoadingMore == NO) {
                [_dataArray removeAllObjects];
            }
            
            [_dataArray addObjectsFromArray:request.handleredResult[@"dataArray"]];
            for (NewsModel *model in _dataArray) {
                BOOL isReaded = [ArticleReadCach hasReaded:model.newsId withType:NewsArticle];
 
                if (isReaded) {
                    model.isChecked = YES;
                }
            }
            if (_page == 1) {
                
                [_cache addData:_dataArray WithKey:@"NewsViewController"];
            }
        } else {
            [_tableView setLoadMoreViewHidden:YES];
        }
        
        
        
      //  NSLog(@"_dataArray.count_dataArray.count %d",_dataArray.count);
        _tableView.pullTableIsLoadingMore = NO;
        _tableView.pullTableIsRefreshing = NO;
        [_tableView reloadData];
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
   //     [loadingView removeFromSuperview];
        _tableView.pullTableIsLoadingMore = NO;
        _tableView.pullTableIsRefreshing = NO;
      //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
        
    }];
}
-(IBAction)back:(id)sender
{
    if (!_isHomePage) {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }

    
    [self.navigationController popViewControllerAnimated:YES];
//    if (_isHomePage) {
//        return;
//    }
//    MainViewController *mvc = [[MainViewController alloc]init];
//    mvc.isNoShowLogin = YES;
//    mvc.isWineBox = NO;
//    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:mvc];
//    nvc.navigationBarHidden = YES;
//    [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//        
//    }];
   // [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    
}
@end
