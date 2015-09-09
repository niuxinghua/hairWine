//
//  SearchWineViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import "SearchWineViewController.h"
#import "SearchWine.h"
#import "SearchTableViewCell.h"
#import "DetailWineViewController.h"
#import "RecommendWine.h"
#import "PKRevealController.h"
#import "NextSearchWineViewController.h"
@interface SearchWineViewController ()
{
    
    IBOutlet UITextField    *_searchWineTextField;
    IBOutlet UIButton       *_searchWineButton;
    IBOutlet UITableView    *_wineTableView;
    IBOutlet UIButton       *_searchEditeButton;
    NSArray                 *_dataArray;
    NSMutableArray          *_historyDataArray;
    
}

@end

@implementation SearchWineViewController

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
    
    _historyDataArray = [[NSMutableArray alloc]init];
        self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    //_searchWineTextField.text = @"法国干红葡萄酒";
     _historyDataArray = [NSMutableArray arrayWithObjects:@"法国干红葡萄酒",@"宝马庄园红葡萄酒",@"碧尚男爵堡红葡萄酒",@"碧尚女爵堡红葡萄酒",@"碧尚（菩依乐）红葡萄酒", nil];
    [self initView];
   
}

#pragma mark - initView

- (void)initView
{
    [_searchWineTextField setValue:[UIColor colorWithRed:201/255.0 green:168/255.0 blue:158/255.0 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    _searchWineTextField.delegate = self;
    _wineTableView.delegate = self;
    _wineTableView.dataSource = self;
   // _wineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getRequest];
    
}

#pragma mark - getRequest


- (void)getRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 64+44, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 44+44, self.view.bounds.size.width, self.view.bounds.size.height);
    }

    //loadingView.frame = CGRectMake(0, 64+44, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:loadingView];
    [RecommendWineRequest requestWithParameters:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
        _dataArray = request.handleredResult[@"RecommendWine"];
        
      //  _searchWineTextField.placeholder = request.handleredResult[@"recomentWineDefault"];
        _searchWineTextField.text = request.handleredResult[@"recomentWineDefault"];
        [_wineTableView reloadData];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
    }];
}

#pragma mark - buttonClick

- (IBAction)backbuttonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)searchButton:(id)sender
{
    NextSearchWineViewController *nsv = [[NextSearchWineViewController alloc]init];
    nsv.wineNameDefault = _searchWineTextField.placeholder;
    [self.navigationController pushViewController:nsv animated:NO];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_searchWineTextField resignFirstResponder];
    NextSearchWineViewController *nsv = [[NextSearchWineViewController alloc]init];
    nsv.isShowKeyboard = YES;
    [self.navigationController pushViewController:nsv animated:NO];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"searchWine";
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [SearchTableViewCell cellFromNib];
    }
//    cell.editImageView.hidden = YES;
//    cell.editImageViewSelected.hidden = YES;
    RecommendWine *recommendWine = [_dataArray objectAtIndex:indexPath.row];
    cell.Namelabel.text = recommendWine.WineName;
 //   cell.wineNameLabel.text = recommendWine.WineName;
    return cell;
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    cell.textLabel.text = recommendWine.WineName;
//    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendWine *wine = [_dataArray objectAtIndex:indexPath.row];
    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    [dic setValue:DATA_ENV.userid forKey:@"appid"];
//    [dic setValue:wine.WineID forKey:@"goodsid"];
//    [UserScanAddRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestFinished:^(ITTBaseDataRequest *request) {
//        
//    }];
    
    DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
    dvc.wineID = wine.WineID;
    dvc.wineName = wine.WineName;
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma  mark - editdingbutton

- (IBAction)editeButton:(id)sender
{
    _searchWineTextField.placeholder = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
