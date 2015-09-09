//
//  DetailViewController.m
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "DetailNewsModel.h"

#define HaierDataCacheManager ([HaierDataCacheManager sharedManager])

@interface DetailViewController (){
    
    IBOutlet UIScrollView   *_picScrollView;
    IBOutlet UIPageControl  *_pageControl;
    IBOutlet UILabel        *_titleLabel;
    IBOutlet UILabel        *_dateLabel;
    IBOutlet UILabel        *_contentLabel;
    IBOutlet UIScrollView   *_mainScrollView;
    IBOutlet UILabel        *_fromLabel;
    IBOutlet UILabel        *_subjectLabel;
   
    
    NSInteger               *_picNum;
    CGFloat                  _contentLabelOrignY;
//    HaierDataCacheManager   *_cache;
//    BOOL                     _hasCache;
//    BOOL                     _hasObject;
}

@end

@implementation DetailViewController

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
    NSString *string;
    _contentLabelOrignY = _contentLabel.origin.y;
    //9.13
    if (_type == NewsDetailType) {
        
        _subjectLabel.text = @"新闻详情";
        
        //缓存
        string = [NSString stringWithFormat:@"News%@",_newsId];
        
    } else if (_type == ProfessionalDetailType){
        
        [_subjectLabel setText:@"专业品鉴"];
        string = [NSString stringWithFormat:@"Professional%@",_newsId];
        
    } else if (_type == ExperienceDetailType){
        
        [_subjectLabel setText:@"品鉴心得"];
        string = [NSString stringWithFormat:@"Experience%@",_newsId];
        
    } else if (_type == MessageDetailType){
        
        [_subjectLabel setText:@"消息详情"];
        
    }
    
    //9.13
    if ([HaierDataCacheManager isHaveDataWithKey:string]) {
        
        DetailNewsModel *model = (DetailNewsModel *)[HaierDataCacheManager getDataWithKey:string].lastObject;
        [self fillDataToView:model];
        
    }
    
        [self requestMethod];
    
//    _hasObject = NO;
    /*
    if ([_cache isHaveDataWithKey:@"NewsDetail"]) {
        
        _hasCache = YES;
        NSArray *array = [_cache getDataWithKey:@"NewsDetail"];
        
        NSDictionary *dic;
        for (int i = 0; i < array.count; i++) {
            
         dic = (NSDictionary *)array[i];
            if ([dic objectForKey:_newsId] != nil) {
                _hasObject = YES;
                break;
            }
            
        }
        
        if (_hasObject) {
            
            ITTBaseDataRequest *request =(ITTBaseDataRequest *)[dic objectForKey:_newsId];
            [self fillDataToView:request];
        } else {
            [self requestMethod];
        }
        
    } else {
        
        _hasCache = NO;
        [self requestMethod];
    }
    */
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

    //loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    switch (_type) {
        case NewsDetailType:
        {
        
            [dic setValue:DATA_ENV.userid forKey:@"appId"];
            [dic setValue:_newsId forKey:@"id"];
            [NewsDetailRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                
                [loadingView removeFromSuperview];
                if ([request isSuccess]) {
                    
                    
                    DetailNewsModel *model = (DetailNewsModel *)request.handleredResult[@"DetailNewsModel"];
                    
                    NSArray *array = [NSArray arrayWithObject:model];
                    NSString *string = [NSString stringWithFormat:@"News%@",_newsId];
                    [HaierDataCacheManager addData:array WithKey:string];
                    
                    [self fillDataToView:model];
                    
                }
                
                
                
            } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                [loadingView removeFromSuperview];
                //   [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
            }];
            
        }
            break;
            
        case ProfessionalDetailType:
        {
            [dic setValue:_newsId forKey:@"id"];
            [dic setValue:DATA_ENV.userid forKey:@"appId"];
            [ProfessionalDetailRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                
                [loadingView removeFromSuperview];
                if ([request isSuccess]) {
                    
                    DetailNewsModel *model = (DetailNewsModel *)request.handleredResult[@"DetailNewsModel"];
                    
                    NSArray *array = [NSArray arrayWithObject:model];
                    NSString *string = [NSString stringWithFormat:@"Professional%@",_newsId];
                    [HaierDataCacheManager addData:array WithKey:string];
                    
                    [self fillDataToView:model];
                }
                
            } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                [loadingView removeFromSuperview];
                //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
            }];
        }
            break;

        case ExperienceDetailType:
        {
            [dic setValue:_newsId forKey:@"id"];
            [dic setValue:DATA_ENV.userid forKey:@"appId"];
            
            [ExperienceDetailRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                
                [loadingView removeFromSuperview];
                if ([request isSuccess]) {
                    
                    DetailNewsModel *model = (DetailNewsModel *)request.handleredResult[@"DetailNewsModel"];
                    
                    NSArray *array = [NSArray arrayWithObject:model];
                    NSString *string = [NSString stringWithFormat:@"Experience%@",_newsId];
                    [HaierDataCacheManager addData:array WithKey:string];
                    
                    [self fillDataToView:model];
                    
                }
                
                
            } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                [loadingView removeFromSuperview];
                //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
            }];
        }
            break;

        case MessageDetailType:
        {
            
            [loadingView removeFromSuperview];

        }
            break;
            
        default:
            break;
    }
    
    
}



#pragma mark - fillDataToView
-(void)fillDataToView:(DetailNewsModel *)model
{
    //图片
    
    NSArray *picArr = model.newsPicArr;
    NSInteger count = picArr.count;
   // NSInteger width = 294 * count;
    _picScrollView.contentSize = CGSizeMake(294, 165);
    _pageControl.numberOfPages = count;
    for (int i = 0; i < count; i++) {
        ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(i*294, 0, 294, 165)];
        NSDictionary *picDic = picArr[i];
        imageView.image = [UIImage imageNamed:@"588x330"];
        [imageView loadImage:[picDic objectForKey:@"news_pic"] placeHolder:[UIImage imageNamed:@"588x330"]];
        [_picScrollView addSubview:imageView];
        
    }
    
    //题目
    _titleLabel.text = model.newsTitle;
    //来源
    _fromLabel.text = model.newsSource;
    CGSize size = [model.newsSource sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(9999, 21) lineBreakMode:NSLineBreakByCharWrapping];
    if (size.width > 120) {
        _fromLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _fromLabel.frame = CGRectMake(13, 59, 120, 16);

    } else {
    _fromLabel.frame = CGRectMake(13, 59, size.width, 16);
    }
    //日期
    _dateLabel.text = [self timeFormat:model.newsDate];
    if (_fromLabel.frame.size.width == 0) {
        
        _dateLabel.left = 13 + _fromLabel.frame.size.width;

    } else {
    
        _dateLabel.left = 13 + _fromLabel.frame.size.width + 10;

    }
    //内容

    //9.25
    NSArray *contentArr = [model.newsContent componentsSeparatedByString:@"\r\n"];
    NSString *contentStr = [contentArr componentsJoinedByString:@"\r\n       "];
    _contentLabel.text = [NSString stringWithFormat:@"       %@",contentStr];
    CGFloat height = [UILabel layoutLabelHeightText:_contentLabel.text font:[UIFont systemFontOfSize:17] width:290];
    _contentLabel.frame = CGRectMake(_contentLabel.origin.x, _contentLabelOrignY+24, 290, height);
    _contentLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    _contentLabel.layer.borderWidth=1;
    _mainScrollView.contentSize =CGSizeMake(320, _contentLabel.frame.origin.y+height+74);
    
    
}

#pragma mark -timeFormat method
-(NSString *)timeFormat:(NSString *)time
{
    
    NSString *ret;
    NSDate *dateNow = [NSDate date];
    NSDate *date = [NSDate dateWithString:time formate:@"yyyy-MM-dd HH:mm:ss.S"];
    NSTimeInterval interval = -[date timeIntervalSinceNow];
 //   NSLog(@"interval %@",dateNow);
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
    //    ret = [NSString stringWithFormat:@"昨天 %@",hourTime];
    } else {
        ret = [format2 stringFromDate:date];
    }
    return ret;
}

//-(void)setType:(DetailType)type{
//    _type = type;
//    if (_type == NewsDetailType) {
//
//        _subjectLabel.text = @"新闻详情";
//        
//    } else if (_type == ProfessionalDetailType){
//        
//        [_subjectLabel setText:@"专业品鉴"];
//    
//    } else if (_type == ExperienceDetailType){
//        
//        [_subjectLabel setText:@"品鉴心得"];
//    
//    } else if (_type == MessageDetailType){
//        
//        [_subjectLabel setText:@"消息详情"];
//    
//    }
//}

#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100) {
        NSInteger page = scrollView.contentOffset.x/294;
        _pageControl.currentPage = page;
    }
}
@end
