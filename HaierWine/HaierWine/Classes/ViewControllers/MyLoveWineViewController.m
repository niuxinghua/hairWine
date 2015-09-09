//
//  MyLoveWineViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import "MyLoveWineViewController.h"
#import "MyLoveWineTableViewCell.h"
#import "MyLoveWine.h"
#import "PKRevealController.h"
#import "DetailWineViewController.h"
#import "LoginViewController.h"

@interface MyLoveWineViewController ()
{
    
    IBOutlet UIView *_selectAllView;
    IBOutlet UIButton *_selectAllButton;
    IBOutlet ITTPullTableView    *_myLoveWineTableView;
    IBOutlet UIButton       *_rightButton;
    IBOutlet UILabel        *_titleLabel;
    IBOutlet UILabel        *_delegateLabel;
    IBOutlet UIImageView    *_delegateImageView;
    IBOutlet UIImageView    *_rightImageView;
    IBOutlet UIImageView    *_imageView;
    IBOutlet UILabel        *_label;
    NSMutableArray          *_dataArray;
    NSInteger                _page;

    IBOutlet UIButton       *_editbtn;
    BOOL                    _isSelectedToDel;
}
@end

@implementation MyLoveWineViewController

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
    _titleLabel.text = _navTitle;
    _imageView.image = [UIImage imageNamed:_imageName];
    _label.text = _text;
    [self initTableView];
    [self getRequest];
//    if (!DATA_ENV.userid && DATA_ENV.userid.length < 1) {
//        LoginViewController *login = [[LoginViewController alloc]init];
//        [self presentModalViewController:login animated:YES];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.revealController.recognizesPanningOnFrontView = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
}

#pragma mark - initTableView

- (void)initTableView
{
    _dataArray = [[NSMutableArray alloc]init];
    _page = 1;
//    for(int i = 0; i<10;i++){
//        MyLoveWine *myloveWine = [[MyLoveWine alloc]init];
//        myloveWine.wineName =[NSString stringWithFormat:@"法国干红葡萄酒--%d",i];
//        myloveWine.isChecked = NO;
//        [initArray addObject:myloveWine];
//    }
//    _dataArray = initArray;
    if (DATA_ENV.userid != nil) {
        
        [self getRequest];

    } else {
    
        _myLoveWineTableView.hidden = YES;
        _rightImageView.hidden = YES;
        _editbtn.enabled = NO;

    }
    self.navigationController.navigationBarHidden = YES;
    _myLoveWineTableView.delegate = self;
    _myLoveWineTableView.dataSource = self;
    _myLoveWineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myLoveWineTableView.allowsSelectionDuringEditing = YES;
    _myLoveWineTableView.pullDelegate = self;
    [_myLoveWineTableView setRefreshViewHidden:NO];
    if ([_type isEqualToString:@"1"]) {
        //用户浏览
        [_myLoveWineTableView setLoadMoreViewHidden:YES];
    }
    
}

- (void)getRequest
{
    
//    LoadingView *loadingView = [LoadingView loadFromXib];
//    
//    loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
//    
//    [self.view addSubview:loadingView];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if ([_type isEqualToString:@"1"]) {
        //用户浏览
        [parameters setValue:DATA_ENV.userid forKey:@"appid"];
        [UserScanListRequest requestWithParameters:parameters withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
            
            if ([request isSuccess]) {
                
      //          [loadingView removeFromSuperview];
                
                _dataArray = request.handleredResult[@"dataArray"];
                
                if (_dataArray.count == 0) {
                    _myLoveWineTableView.hidden = YES;
                    _rightImageView.hidden = YES;
                    _editbtn.enabled = NO;
                }
                
            } else {
                
                _myLoveWineTableView.hidden = YES;
                _rightImageView.hidden = YES;
                _editbtn.enabled = NO;
                
            }
            
            _myLoveWineTableView.pullTableIsRefreshing = NO;
            [_myLoveWineTableView reloadData];
            
        } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
            _myLoveWineTableView.pullTableIsRefreshing = NO;
      //      [loadingView removeFromSuperview];
        }];
        
        
    } else if ([_type isEqualToString:@"2"]){
    //我的爱酒
        /*
            for(int i = 0; i<10;i++){
                MyLoveWine *myloveWine = [[MyLoveWine alloc]init];
                myloveWine.wineName =[NSString stringWithFormat:@"法国干红葡萄酒--%d",i];
                myloveWine.isChecked = NO;
                [_dataArray addObject:myloveWine];
            }
        */
        NSString *_pageStr = [NSString stringWithFormat:@"%d",_page];
        
        [parameters setValue:DATA_ENV.userid forKey:@"appId"];
        [parameters setValue:_pageStr forKeyPath:@"page"];
        [FavouriteWineListRequest requestWithParameters:parameters withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
            
        } onRequestFinished:^(ITTBaseDataRequest *request) {
          //  NSLog(@"%@",temp);
            if ([request isSuccess]) {
      //          [loadingView removeFromSuperview];
                NSArray *temp = request.handleredResult[@"MyLoveWine"];
                
                if (temp.count < 10) {
                    
                    [_myLoveWineTableView setLoadMoreViewHidden:YES];
                    
                }
                
                if (_myLoveWineTableView.pullTableIsLoadingMore == NO) {
                    [_dataArray removeAllObjects];
                }
                
                [_dataArray addObjectsFromArray:request.handleredResult[@"MyLoveWine"]];
            } else {
                
                [_myLoveWineTableView setLoadMoreViewHidden:YES];
                _myLoveWineTableView.hidden = YES;
                _rightImageView.hidden = YES;
                _editbtn.enabled = NO;
            }

            
            if (_myLoveWineTableView.pullTableIsLoadingMore == NO) {
                [_dataArray removeAllObjects];
            }
           // _dataArray = temp;
            [_dataArray addObjectsFromArray:request.handleredResult[@"MyLoveWine"]];

            _myLoveWineTableView.pullTableIsLoadingMore = NO;
            _myLoveWineTableView.pullTableIsRefreshing = NO;
            [_myLoveWineTableView reloadData];

        } onRequestCanceled:^(ITTBaseDataRequest *request) {
            
        } onRequestFailed:^(ITTBaseDataRequest *request) {
    //        [loadingView removeFromSuperview];
            _myLoveWineTableView.pullTableIsLoadingMore = NO;
            _myLoveWineTableView.pullTableIsRefreshing = NO;
        }];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"winePrice";
    MyLoveWineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [MyLoveWineTableViewCell cellFromNib];
        
        //666666
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:218.0/255.f green:218.0/255.f blue:218.0/255.f alpha:1];
    }
    
    MyLoveWine *myLoveWine = [_dataArray objectAtIndex:indexPath.row];
   // NSLog(@"_dataArray==%@",_dataArray);
    if ([_type isEqualToString:@"1"]) {
        //用户浏览
        cell.wineNameLabel.text = myLoveWine.scanwineName;
        [cell.wineImageView loadImage:myLoveWine.wineScanPic placeHolder:[UIImage imageNamed:@"120x120"]];
        
    } else {
        //我的爱酒
    cell.wineNameLabel.text = myLoveWine.wineName;
    [cell.wineImageView loadImage:myLoveWine.winePic placeHolder:[UIImage imageNamed:@"120x120"]];
        
    }
    

    
    if (_editbtn.selected) {
        
        if (myLoveWine.isChecked) {
            
            cell.editImageViewSelected.hidden = NO;
        } else {
        
            cell.editImageViewSelected.hidden = YES;

        }
        cell.editImageView.hidden = NO;
        cell.narrowImageView.hidden = YES;
    
    } else {
    
   
    cell.editImageView.hidden = YES;
    cell.editImageViewSelected.hidden = YES;
    cell.narrowImageView.hidden = NO;
//    [cell setChecked:myLoveWine.isChecked];
        
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyLoveWine *myLoveWine = [_dataArray objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_editbtn.selected) {
        MyLoveWineTableViewCell *cell = (MyLoveWineTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        myLoveWine.isChecked = !myLoveWine.isChecked;
        [cell setChecked:myLoveWine.isChecked];
        cell.editImageViewSelected.hidden = !cell.editImageViewSelected.hidden;

    } else {
    //进入详情
        DetailWineViewController *detail = [[DetailWineViewController alloc]init];
        MyLoveWine *wine  = _dataArray[indexPath.row];
        detail.wineID = wine.wineGoodsId;
        detail.wineName = wine.wineName;
        [self.navigationController pushViewController:detail animated:YES];
        
    }
}

#pragma mark - buttonClick

- (IBAction)backButton:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    if (_editbtn.isSelected){
        //      _delegateLabel.hidden = YES;
        //      _delegateImageView.hidden = NO;
        //      _rightImageView.image = [UIImage imageNamed:@"multiple_choice_icon"];
        _editbtn.selected = NO;
        //      [_myLoveWineTableView setEditing:NO animated:YES];
        for (MyLoveWine *wine in _dataArray) {
            wine.isChecked = NO;
        }
        _delegateImageView.hidden = NO;
        _delegateLabel.hidden = YES;
        _rightImageView.image = [UIImage imageNamed:@"multiple_choice_icon.png"];
        _myLoveWineTableView.top = _myLoveWineTableView.top - 44;
        _selectAllView.hidden = YES;
        [_myLoveWineTableView reloadData];
    } else {
        if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
        {
            [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
        }
        else
        {
            [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
        }
    }
    
}

- (IBAction)editButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
 
    if (!button.selected) {
        //
        for (int i = 0; i < _dataArray.count; i++) {
            MyLoveWine *myLoveWine = _dataArray[i];
            if (myLoveWine.isChecked == YES) {
                _isSelectedToDel = YES;
                break;
            }
            
        }
        if (_isSelectedToDel) {
            /*
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 100;
            [alert show];
            */
            DeleteAlertView *alertView = [DeleteAlertView loadFromXib];
            alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            alertView.type = DeleteAlertViewTypeAskSure;
            alertView.delegate = self;
            [self.view addSubview:alertView];
            
            
        } else {
            
            /*
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"未选中任何记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 101;
            [alert show];
             */
            DeleteAlertView *alertView = [DeleteAlertView loadFromXib];
            alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            alertView.type = DeleteAlertViewTypeNoSelected;
            alertView.delegate = self;
            [self.view addSubview:alertView];
            
        }
        
    } else {
        _myLoveWineTableView.top = _myLoveWineTableView.top + 44;
        _selectAllView.hidden = NO;
        _selectAllButton.selected = NO;
        _delegateImageView.hidden = YES;
        _delegateLabel.hidden = NO;
      //  [_myLoveWineTableView setEditing:button.selected animated:NO];
        [_myLoveWineTableView reloadData];
        _rightImageView.image = [UIImage imageNamed:@"multiple_delegate_icon"];
    }
}
/*
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) {
        _rightImageView.image = [UIImage imageNamed:@"multiple_delegate_icon"];
        _editbtn.selected = YES;
        return;
    }
    _isSelectedToDel = NO;
 //   [_myLoveWineTableView setEditing:!_myLoveWineTableView.editing animated:YES];
    NSMutableArray *array = [NSMutableArray arrayWithArray:_dataArray];
 //   NSMutableArray *delArray = [[NSMutableArray alloc]init];
    NSMutableString *delStr = [[NSMutableString alloc]init];
    BOOL first = YES;
    for (int i = 0;i<array.count;i++) {
        MyLoveWine *wine = [array objectAtIndex:i];
        if (wine.isChecked) {
        //    [delArray addObject:wine.wineGoodsId];
            if (first) {
                [delStr appendFormat:@"%@",wine.wineId];
                first = NO;
            } else {
                [delStr appendFormat:@",%@",wine.wineId];
            }
            [_dataArray removeObject:wine];
        }
    }
    
    if (_dataArray.count == 0) {
        _myLoveWineTableView.hidden = YES;
        _rightImageView.hidden = YES;
        _editbtn.enabled = NO;
    }
    
    NSLog(@"dddddddddddd%@",delStr);
    //删除服务器数据
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:delStr forKey:@"ids"];
    if ([_type isEqualToString:@"1"]) {
        
        //用户浏览
        [UserScanDeleteRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestFinished:^(ITTBaseDataRequest *request) {
            
        }];
    } else {
        
        //我的爱酒
        [FavouriteWineDeleteRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
            
        } onRequestFinished:^(ITTBaseDataRequest *request) {
            NSLog(@"ddddddddddlllll%@",request.handleredResult);
        } onRequestCanceled:^(ITTBaseDataRequest *request) {
            
        } onRequestFailed:^(ITTBaseDataRequest *request) {
            
        }];
    }
    
    _rightImageView.image = [UIImage imageNamed:@"multiple_choice_icon"];
    _delegateImageView.hidden = NO;
    _delegateLabel.hidden = YES;
    
    [_myLoveWineTableView reloadData];
}
*/
#pragma mark - delete AlertView delegate
- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type
{
    if (type == DeleteAlertViewTypeNoSelected) {
        
        //未选择纪录
        if (tag == 0) {
            //取消
            _editbtn.selected = !_editbtn.selected;
            
        } else if (tag == 1){
            //确定
            _editbtn.selected = !_editbtn.selected;

        }
        
    } else if (type == DeleteAlertViewTypeAskSure){
        
       //是否删除
        if (tag == 0) {
            //取消
            _rightImageView.image = [UIImage imageNamed:@"multiple_delegate_icon"];
            _editbtn.selected = YES;
            return;
        }
        
        _isSelectedToDel = NO;
        //   [_myLoveWineTableView setEditing:!_myLoveWineTableView.editing animated:YES];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_dataArray];
        //   NSMutableArray *delArray = [[NSMutableArray alloc]init];
        NSMutableString *delStr = [[NSMutableString alloc]init];
        BOOL first = YES;
        for (int i = 0;i<array.count;i++) {
            MyLoveWine *wine = [array objectAtIndex:i];
            if (wine.isChecked) {
                //    [delArray addObject:wine.wineGoodsId];
                if (first) {
                    [delStr appendFormat:@"%@",wine.wineId];
                    first = NO;
                } else {
                    [delStr appendFormat:@",%@",wine.wineId];
                }
                [_dataArray removeObject:wine];
            }
        }
        
//        if (_dataArray.count == 0) {
//            _myLoveWineTableView.hidden = YES;
//            _rightImageView.hidden = YES;
//            _editbtn.enabled = NO;
//        }
        
      //  NSLog(@"dddddddddddd%@",delStr);
        //删除服务器数据
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:delStr forKey:@"ids"];
        if ([_type isEqualToString:@"1"]) {
            
            //用户浏览
            [UserScanDeleteRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                [self getRequest];
            }];
        } else {
            
            //我的爱酒
            [FavouriteWineDeleteRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
                
            } onRequestFinished:^(ITTBaseDataRequest *request) {
               // NSLog(@"ddddddddddlllll%@",request.handleredResult);
                [self getRequest];
            } onRequestCanceled:^(ITTBaseDataRequest *request) {
                
            } onRequestFailed:^(ITTBaseDataRequest *request) {
                
            }];
        }
        
        _rightImageView.image = [UIImage imageNamed:@"multiple_choice_icon"];
        _delegateImageView.hidden = NO;
        _delegateLabel.hidden = YES;
        _myLoveWineTableView.top = _myLoveWineTableView.top - 44;
        _selectAllView.hidden = YES;
        [_myLoveWineTableView reloadData];
        
    }
    
}

- (IBAction)selectButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
        for (MyLoveWine *myLoveWine in _dataArray) {
            if (btn.selected) {
                myLoveWine.isChecked = YES;
            } else {
                myLoveWine.isChecked = NO;
            }
        }
    [_myLoveWineTableView reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ittpulltableview delegate
- (void)pullTableViewDidTriggerRefresh:(ITTPullTableView*)pullTableView
{
    if ([_type isEqualToString:@"2"]) {
        
        [_myLoveWineTableView setLoadMoreViewHidden:NO];
        _page = 1;
    }
    
        [self getRequest];
    
}
- (void)pullTableViewDidTriggerLoadMore:(ITTPullTableView*)pullTableView
{
    
    _page++;
    [self getRequest];
}
@end
