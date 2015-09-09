//
//  NextSearchWineViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-26.
//
//

#import "NextSearchWineViewController.h"
#import "MyLoveWineTableViewCell.h"
#import "ITTDataCacheManager.h"
#import "SearchWine.h"
#import "SearchTableViewCell.h"
#import "DetailWineViewController.h"

#define SEARCH_HISTORY @"searchHistory"

@interface NextSearchWineViewController ()
{
    
    IBOutlet UIView       *_commentView;
    IBOutlet UIView       *_historyView;
    IBOutlet UIView       *_claerHistoryView;
    IBOutlet UIButton     *_editeDeleteButton;
    IBOutlet UITableView  *_searchTableView;
    IBOutlet UITableView  *_wineTableView;
    IBOutlet UITextField  *_searchTextField;
    
    NSMutableArray        *_historyDataArray;
    NSArray               *_dataArray;
    NSString              *_PreviousText;
    BOOL                  _isShowHistory;
    
}

@end

@implementation NextSearchWineViewController

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
    [self initSearchHistoryData];
    [self initTableView];
    [self initSearchTextField];
    _isShowHistory = NO;
    _editeDeleteButton.hidden = YES;
}

#pragma  mark - init

- (void)initTableView
{
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.separatorColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    _searchTableView.hidden = NO;
    _searchTableView.height = _searchTableView.height;
    _wineTableView.delegate = self;
    _wineTableView.dataSource =self;
    _wineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // _wineTableView.rowHeight = 80;
    _wineTableView.hidden = YES;
}

- (void)initSearchHistoryData
{
    _historyDataArray = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:SEARCH_HISTORY];
    if (_historyDataArray == nil) {
        _historyDataArray = [[NSMutableArray alloc]init];
    }
    if (_historyDataArray.count == 0){
        _searchTableView.tableFooterView = _historyView;
    } else {
        _searchTableView.tableFooterView = _claerHistoryView;
    }
}

- (void)initSearchTextField
{
    _searchTextField.delegate = self;
    if(_isShowKeyboard){
        [_searchTextField becomeFirstResponder];
    }
    [_searchTextField setValue:[UIColor colorWithRed:201/255.0 green:168/255.0 blue:158/255.0 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
   [_searchTextField addTarget:self action:@selector(textFieldValueChanged) forControlEvents:UIControlEventEditingChanged];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged) name:UITextFieldTextDidChangeNotification object:nil];
    if (_wineNameDefault != nil) {
        _searchTextField.text = _wineNameDefault;
        _searchTableView.hidden = YES;
        [self addHistory:_wineNameDefault];
        [self searchWineRequest:_wineNameDefault];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [textField.text stringByTrimmingCharactersInSet:set];
    if (trimedString.length!=0) {
        [self addHistory:_searchTextField.text];
        [self searchWineRequest:_searchTextField.text];
        [textField resignFirstResponder];

    } else {
        [UIAlertView popupAlertByDelegate:nil title:nil message:@"输入不能为空"];
        [textField resignFirstResponder];

    }
    
    return YES;
}

- (void)addHistory:(NSString *)wineName
{
    if (![self historyArrayHasWineName:wineName]) {
        // [_historyDataArray addObject:_searchTextField.text];
        [_historyDataArray insertObject:wineName atIndex:0];
        if (_historyDataArray.count == 11) {
            [_historyDataArray removeLastObject];
        }
        [[ITTDataCacheManager sharedManager] addObject:_historyDataArray forKey:SEARCH_HISTORY];
        _searchTableView.tableFooterView = _claerHistoryView;
        
    }

}

- (void)textFieldValueChanged
{
    //NSLog(@"_PreviousText==%@",_PreviousText);
//    NSLog(@"_searchTextField.text==%@",_searchTextField.text);
//    if([_PreviousText isEqualToString:_searchTextField.text]){
//    NSLog(@"-------%@",_searchTextField.text);
//        _PreviousText = nil;
//        return;
//    }else if (_PreviousText.length>_searchTextField.text.length){
//        
//        NSLog(@"删除");
//    }else
//    {
//        _PreviousText = _searchTextField.text;
//    }
//    NSLog(@"_PreviousText==%@",_PreviousText);
//    [self searchWineRequest:_searchTextField.text];

    //if()
}

#pragma mark - searchCancelButton

- (IBAction)_searchCancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)_editeDeleteButton:(id)sender
{
    _searchTextField.text = nil;
    [_searchTextField becomeFirstResponder];
    _editeDeleteButton.hidden = YES;
    _searchTableView.hidden = NO;
    [_searchTableView reloadData];
    _wineTableView.hidden = YES;
    [_commentView removeFromSuperview];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _searchTableView) {
        return _historyDataArray.count;
    } else {
        return _dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _wineTableView) {
        static NSString *cellId = @"winePrice";
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [SearchTableViewCell cellFromNib];
        }
       // cell.editImageView.hidden = YES;
        //cell.editImageViewSelected.hidden = YES;
        SearchWine *searchWine = [_dataArray objectAtIndex:indexPath.row];
        //[cell.wineImageView loadImage:searchWine.wineImageUrl placeHolder:[UIImage imageNamed:@"120x120"]];
        cell.Namelabel.text= searchWine.wineName;
      //  NSLog(@"%@",searchWine.wineName);
        return cell;
    } else {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
        UIView *bgview = [[UIView alloc]initWithFrame:cell.bounds];
        bgview.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        cell.selectedBackgroundView = bgview;
    }
        cell.textLabel.text = [_historyDataArray objectAtIndex:indexPath.row];
    return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _searchTableView){
        _searchTableView.hidden = YES;
        _wineTableView.hidden = NO;
        _searchTextField.text = [_historyDataArray objectAtIndex:indexPath.row];
        _editeDeleteButton.hidden = NO;
        [self searchWineRequest:_searchTextField.text];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *wineName;
    if (tableView == _wineTableView) {
        SearchWine *searchWine = [_dataArray objectAtIndex:indexPath.row];
       // NSLog(@"wineName=%@",searchWine.wineName);
        wineName = searchWine.wineName;
        
        DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
        dvc.wineID = searchWine.wineId;
        dvc.wineName = searchWine.wineName;
        [self.navigationController pushViewController:dvc animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView*)scrollView;
    if (tableView == _searchTableView) {
        [_searchTextField resignFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   // NSLog(@"text-%@----string-%@-%d-%d",_searchTextField.text,string,range.location,range.length);
    if (textField.text != nil) {
          _editeDeleteButton.hidden = NO;
    }
    if(_searchTextField.text.length==1&&range.length ==1){
          _editeDeleteButton.hidden=YES;
        _isShowHistory = YES;
        _wineTableView.hidden = YES;
        _searchTableView.hidden = NO;
        [_commentView removeFromSuperview];
        [_searchTableView reloadData];
    } else {
        _isShowHistory = NO;
    }
    return YES;
}

#pragma mark - textFieldDelegate

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark - searchWineRequest

- (void)searchWineRequest:(NSString *)wineName
{
    
   // NSLog(@"wineName-%@",DATA_ENV.userid);
    if (DATA_ENV.userid == nil) {
        DATA_ENV.userid = @"0";
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    wineName = [wineName stringByTrimmingCharactersInSet:set];

   // wineName = [wineName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary *paremer = @{@"name": [AFBase64EncodedStringFromString(wineName) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"appId":DATA_ENV.userid};
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

    //loadingView.frame = CGRectMake(0, 64+44, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:loadingView];
    [SearchWineRequest requestWithParameters:paremer withRequestUrl:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([request.handleredResult[@"result"] isEqualToString:@"1"] ) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
                _commentView.top = 64;
                _wineTableView.top = 64+79;
                _wineTableView.height = 429;
            } else {
                _commentView.top = 44;
                _wineTableView.top = 64+79;
                _wineTableView.height = 429;
            }
            // _wineTableView.tableHeaderView = _commentView;
            [_searchTextField resignFirstResponder];
            [self.view addSubview:_commentView];
            _searchTableView.hidden = YES;

        } else {
            // _wineTableView.tableHeaderView = nil;
            [_commentView removeFromSuperview];
            _wineTableView.top = 64;
            _wineTableView.height = 508;
        }
        [loadingView removeFromSuperview];

        if (_isShowHistory) {
            return;
        }
        _wineTableView.hidden = NO;
        _dataArray = request.handleredResult[@"SearchWine"];
        //   NSLog(@"***%@",_dataArray);
        [_wineTableView reloadData];
       // [loadingView removeFromSuperview];

    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];

    }];
}

#pragma mark - clearHistory

- (IBAction)clearHistory:(id)sender
{
    [_searchTextField resignFirstResponder];
    DeleteAlertView *alert = [DeleteAlertView loadFromXib];
    alert.type = DeleteAlertViewTypeSearchHistory;
    alert.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    alert.delegate = self;
    [self.view addSubview:alert];
}

- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type
{
    if (type == DeleteAlertViewTypeSearchHistory) {
        if (tag == 0) {
            return;
        } else if (tag == 1){
            [_historyDataArray removeAllObjects];
            [[ITTDataCacheManager sharedManager] addObject:_historyDataArray forKey:SEARCH_HISTORY];
            _searchTableView.tableFooterView = _historyView;
            [_searchTableView reloadData];
  
        }
    }
}

#pragma mark - AFBase64EncodedStringFromString

static NSString * AFBase64EncodedStringFromString(NSString *string) {
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

- (BOOL)historyArrayHasWineName:(NSString *)wineName
{
    for (NSString *str in _historyDataArray) {
        if ([str isEqualToString:wineName]) {
            return YES;
        }
    }
    return NO;
}

@end
