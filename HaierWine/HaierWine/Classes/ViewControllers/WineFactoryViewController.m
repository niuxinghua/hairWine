//
//  WineFactoryViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "WineFactoryViewController.h"
#import "WineFactoryTableViewCell.h"
#import "WineFactoryDeatil.h"
#import "winePrice.h"
#import "ITTImageView.h"
#import "DetailWineViewController.h"
@interface WineFactoryViewController ()
{
    
    IBOutlet UIPageControl *_wineFactoryPagecontrol;
    IBOutlet UIScrollView  *_winePicScrollView;
    IBOutlet UITableView   *_wineTableView;
    IBOutlet UIView        *_headerView;
    IBOutlet UILabel       *_wineFactoryInfoLabel;
    IBOutlet UILabel       *_wineAreaLabel;
    IBOutlet UILabel       *_wineCountryLabel;
    IBOutlet UIButton      *_moreButton;
    IBOutlet UILabel       *_factoryNameLabel;
    IBOutlet UILabel       *_subscribLabel;
    
    NSArray                *_dataArray;
    WineFactoryDeatil      *_wineFactoryDeatil;
    BOOL                   _isLoadData;

}

@end

@implementation WineFactoryViewController

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
    _isLoadData = NO;
    _wineTableView.tableHeaderView = _headerView;
    _factoryNameLabel.text = _factoryName;
    _dataArray = [[NSArray alloc]init];
    if ([_type isEqualToString:@"1"]) {
        _factoryNameLabel.text = @"品牌汇详情";
        _subscribLabel.text = @"品牌简介";
    }
    
    [self getRequest];
   // [self initView];
    
}

- (void)initView
{

    [_winePicScrollView removeAllSubviews];
    NSInteger picCount = _wineFactoryDeatil.wineFactoryPicsArray.count;
        _winePicScrollView.contentSize = CGSizeMake(320*picCount, 240);
        _wineFactoryPagecontrol.numberOfPages = picCount;
        _wineFactoryPagecontrol.enabled = NO;
        _wineFactoryPagecontrol.hidesForSinglePage = YES;
        if (picCount ==0) {
        ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 240)];
            imageView.image = [UIImage imageNamed:@"640x480"];
            [_winePicScrollView addSubview:imageView];

        }
        for (int i = 0 ;i<picCount;i++) {
            ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 240)];
             //   NSLog(@"----%@",[_wineFactoryDeatil.wineFactoryPicsArray objectAtIndex:i]);
              [imageView loadImage:[_wineFactoryDeatil.wineFactoryPicsArray objectAtIndex:i] placeHolder:[UIImage imageNamed:@"640x480"] ];
            [_winePicScrollView addSubview:imageView];
        }
        
         _wineFactoryInfoLabel.text = _wineFactoryDeatil.wineFactoryInfo;
        //9.11
    if(_wineFactoryDeatil.wineFactoryInfo==nil){
        _wineFactoryDeatil.wineFactoryInfo = @" ";
    }
        _wineFactoryInfoLabel.text = [NSString stringWithFormat:@"       %@",_wineFactoryDeatil.wineFactoryInfo];
        
        CGFloat labelHeight = [UILabel layoutLabelHeightText:_wineFactoryInfoLabel.text font:[UIFont systemFontOfSize:16] width:275];
        
        if (labelHeight < 59) {
            
            _moreButton.hidden = YES;
            
        }
        _wineCountryLabel.text = _wineFactoryDeatil.wineFactoryCountary;
         _wineAreaLabel.text = _wineFactoryDeatil.wineFactoryAddress;
        
    
    [_wineTableView reloadData];
}

- (void)getRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height);
    }

   // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_wineFactoryID forKey:@"id"];
    
    if ([_type isEqualToString:@"0"]) {
        [wineFactoryRequest requestWithParameters:parameters
                                withIndicatorView:nil
                                withCancelSubject:nil
                                   onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                       
                                       if ([request isSuccess]) {
                                           [loadingView removeFromSuperview];
                                           _wineFactoryDeatil = [request.handleredResult objectForKey:@"wineFactoryDeatil"];
                                           _dataArray = _wineFactoryDeatil.wineFactoryWinesArray;
                                           
                                           //  _wineFactoryScrollView.contentSize = CGSizeMake(320, 560+_dataArray.count);
                                           
                                          // NSLog(@"%@",_wineFactoryDeatil.wineFactoryWinesArray);
                                           _isLoadData = YES;
                                  //         [self initView];
                                       }
                                       
                                       
                                   } onRequestCanceled:nil
                                  onRequestFailed:^(ITTBaseDataRequest *request) {
                                      
                                      [loadingView removeFromSuperview];
                                      [self initView];

                                  }];
    } else if ([_type isEqualToString:@"1"]){
    
        [BrandDetailRequest requestWithParameters:parameters
                                withIndicatorView:nil
                                withCancelSubject:nil
                                   onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                       
                                       if ([request isSuccess]) {
                                           [loadingView removeFromSuperview];
                                           _wineFactoryDeatil = [request.handleredResult objectForKey:@"wineFactoryDeatil"];
                                           _dataArray = _wineFactoryDeatil.wineFactoryWinesArray;
                                           
                                           //  _wineFactoryScrollView.contentSize = CGSizeMake(320, 560+_dataArray.count);
                                           
                                          // NSLog(@"%@",_wineFactoryDeatil.wineFactoryWinesArray);
                                           _isLoadData = YES;
                                           [self initView];
                                       }
                                       
                                   } onRequestCanceled:nil
                                  onRequestFailed:^(ITTBaseDataRequest *request) {
                                      [loadingView removeFromSuperview];
                                //      [self initView];

                                  }];
    }
    
    

}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"winePrice";
    WineFactoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [WineFactoryTableViewCell cellFromNib];
    }
    winePrice *wine = [_dataArray objectAtIndex:indexPath.row];
   // NSLog(@"%@",wine.wineName);
    cell.wineName.text = wine.wineName;
    [cell.winePicURL loadImage:wine.winePic placeHolder:[UIImage imageNamed:@"100x100"]];
    cell.winePrice.text = [NSString stringWithFormat:@"¥%@.00",wine.winePrice];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    winePrice *wine = [_dataArray objectAtIndex:indexPath.row];
    DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
    dvc.wineID = wine.wineId;
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark - increaseLabel

- (IBAction)increaseLabel:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        CGFloat labelHeight = [UILabel layoutLabelHeightText:_wineFactoryInfoLabel.text font:[UIFont systemFontOfSize:16] width:245];
        if (labelHeight <= 59) {
            return;
        }
        _wineFactoryInfoLabel.height = labelHeight;
        _headerView.height = _headerView.height +labelHeight-59;
    } else
    {
        _wineFactoryInfoLabel.height = 59;
        _headerView.height = 572;
    }
    _wineTableView.tableHeaderView = _headerView;
}

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - scrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/320;
    _wineFactoryPagecontrol.currentPage = index;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
