//
//  MyFavouriteWineViewController.m
//  HaierWine
//
//  Created by david on 14/7/10.
//
//

#import "MyFavouriteWineViewController.h"
#import "MyFavouriteWineTableViewCell.h"
#import "MyFavouriteWineModel.h"
@interface MyFavouriteWineViewController (){
    
    NSMutableArray *_dataArray;
    IBOutlet UITableView *_table;
}

@end

@implementation MyFavouriteWineViewController

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
    [self myFavouriteWineRequset];
    // Do any additional setup after loading the view from its nib.
    _table.delegate = self;
    _table.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender
{
    NSLog(@"e");
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - request method
-(void)myFavouriteWineRequset{
    _dataArray = [[NSMutableArray alloc]init];
    [ITTBaseDataRequest requestWithParameters:nil withRequestUrl:nil withIndicatorView:self.view withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        //返回数据类型是什么
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
    }];
}

#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"MyFavouriteWineTableViewCellId";
    MyFavouriteWineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyFavouriteWineTableViewCell" owner:self options:nil]lastObject];
    }
    MyFavouriteWineModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell fillCellWithModel:model];
    
    return cell;
}

@end
