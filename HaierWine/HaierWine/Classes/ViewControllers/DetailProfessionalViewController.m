//
//  DetailProfessionalViewController.m
//  HaierWine
//
//  Created by david on 14/7/31.
//
//

#import "DetailProfessionalViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailNewsModel.h"

#define HaierDataCacheManager ([HaierDataCacheManager sharedManager])

@interface DetailProfessionalViewController (){
    
    IBOutlet UIScrollView   *_picScrollView;
    IBOutlet UIPageControl  *_pageControl;
    IBOutlet UILabel        *_titleLabel;
    IBOutlet UILabel        *_dateLabel;
    IBOutlet UILabel        *_contentLabel;
    IBOutlet UIScrollView   *_mainScrollView;
    
    NSInteger               *_picNum;
}

@end

@implementation DetailProfessionalViewController

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
    NSString *string = [NSString stringWithFormat:@"Professional%@",_ProfessionalId];
    if ([HaierDataCacheManager isHaveDataWithKey:string]) {
        
        DetailNewsModel *model = (DetailNewsModel *)[HaierDataCacheManager getDataWithKey:string].lastObject;
        [self fillDataToView:model];
        
    } 
        
        [self requestMethod];
    
    _picScrollView.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - request method
-(void)requestMethod
{
    
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

   // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_ProfessionalId forKey:@"id"];
    [dic setValue:DATA_ENV.userid forKey:@"appId"];
    [ProfessionalDetailRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        if ([request isSuccess]) {
            
            DetailNewsModel *model = (DetailNewsModel *)request.handleredResult[@"DetailNewsModel"];
            
            NSArray *array = [NSArray arrayWithObject:model];
            NSString *string = [NSString stringWithFormat:@"Professional%@",_ProfessionalId];
            [HaierDataCacheManager addData:array WithKey:string];
            
            [self fillDataToView:model];
        }
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
      //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
    }];
}

#pragma mark - fillDataToView
-(void)fillDataToView:(DetailNewsModel *)model
{
    //图片
    
    NSArray *picArr = model.newsPicArr;
    NSInteger count = picArr.count;
    NSInteger width = 320 * count;
    _picScrollView.contentSize = CGSizeMake(width, 180);
    _pageControl.numberOfPages = count;
    for (int i = 0; i < count; i++) {
        ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 180)];
        NSDictionary *picDic = picArr[i];
        imageView.image = [UIImage imageNamed:@"640x360"];
        [imageView loadImage:[picDic objectForKey:@"news_pic"] placeHolder:[UIImage imageNamed:@"640x360"]];
        [_picScrollView addSubview:imageView];
        
    }
    
    //题目
    _titleLabel.text = model.newsTitle;
    //日期
    _dateLabel.text = [self timeFormat:model.newsDate];
    //内容
    CGFloat height = [UILabel layoutLabelHeightText:model.newsContent font:[UIFont systemFontOfSize:17] width:290];
    _contentLabel.frame = CGRectMake(_contentLabel.origin.x, _contentLabel.origin.y+20, 290, height);
    _contentLabel.text = [NSString stringWithFormat:@"       %@",model.newsContent];
    _contentLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    _contentLabel.layer.borderWidth=1;
    _mainScrollView.contentSize =CGSizeMake(320, _contentLabel.frame.origin.y+height+64);
    
    
}
#pragma mark -timeFormat method
-(NSString *)timeFormat:(NSString *)time
{
    
    NSString *ret;
    NSDate *dateNow = [NSDate date];
    NSDate *date = [NSDate dateWithString:time formate:@"yyyy-MM-dd HH:mm:ss.S"];
    NSTimeInterval interval = -[date timeIntervalSinceNow];
  //  NSLog(@"interval %f",interval);
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
    [format2 setDateFormat:@"MM月dd日"];
    NSDateFormatter *format3 = [[NSDateFormatter alloc]init];
    [format3 setDateFormat:@"dd"];
    NSString* dayTime = [format3 stringFromDate:date];
    NSString* nowTime = [format3 stringFromDate:dateNow];
    NSInteger days = nowTime.integerValue - dayTime.integerValue;
    NSString* hourTime = [format stringFromDate:date];
    if (interval/86400 <= 1 && days == 0) {
        ret = [NSString stringWithFormat:@"今天 %@",hourTime];
    //} else if (interval/172800 <= 1 && days == 1){
      //  ret = [NSString stringWithFormat:@"昨天 %@",hourTime];
    } else {
        ret = [format2 stringFromDate:date];
    }
    return ret;
}

#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100) {
        NSInteger page = scrollView.contentOffset.x/320;
        _pageControl.currentPage = page;
    }
}
@end
