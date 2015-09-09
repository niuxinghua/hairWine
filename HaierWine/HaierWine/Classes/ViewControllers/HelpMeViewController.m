//
//  HelpViewController.m
//  HaierWine
//
//  Created by david on 14/8/7.
//
//

#import "HelpMeViewController.h"
#import "HelpMeDetailViewController.h"
#import "HelpMeModel.h"
@interface HelpMeViewController (){

    IBOutlet ITTPullTableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation HelpMeViewController

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
    [self helpRequestMethod];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setLoadMoreViewHidden:YES];
    [_tableView setRefreshViewHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - helpRequestMethod
-(void)helpRequestMethod
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

   // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    [HelpMeRequest requestWithParameters:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        if ([request isSuccess]) {
            
            _dataArray = request.handleredResult[@"dataArray"];
            [_tableView reloadData];
            
        }
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
      //  NSLog(@"网络连接失败");
    }];
}
-(IBAction)back:(id)sender

{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"HelpMeTableViewCellId";
    HelpMeTableViewCell *cell = (HelpMeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [HelpMeTableViewCell cellFromNib];
        //666666
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:218.0/255.f green:218.0/255.f blue:218.0/255.f alpha:1];
    }
    [cell fillCellWithModel:_dataArray[indexPath.row] andindexPath:indexPath];
    cell.numLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    return cell;
}
/*
-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelpMeDetailViewController *detail = [[HelpMeDetailViewController alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HelpMeModel *model = _dataArray[indexPath.row];
    NSLog(@"=========%@,%@",model.helpMeName,model.helpMeContent);
    detail.titleString = model.helpMeName;
    detail.contentString = model.helpMeContent;
    [self.navigationController pushViewController:detail animated:YES];
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HelpMeDetailViewController *detail = [[HelpMeDetailViewController alloc]init];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HelpMeModel *model = _dataArray[indexPath.row];
   // NSLog(@"=========%@,%@",model.helpMeName,model.helpMeContent);
    detail.titleString = model.helpMeName;
    detail.contentString = model.helpMeContent;
    detail.contentImage = model.helpMeImage;
  //  NSLog(@"%@",detail.contentImage);
    [self.navigationController pushViewController:detail animated:YES];
}
@end
