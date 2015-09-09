//
//  WinesDetailInfoViewController.m
//  HaierWine
//
//  Created by  on 14-7-4.
//
//
#import "WinesDetailInfoViewController.h"
#import "PerWineInfoView.h"
#import "UIColor+RT.h"
#define kImageHeight 240

@interface WinesDetailInfoViewController ()
{
    __weak IBOutlet UIView *_showView;
    __weak IBOutlet UIButton *basicInfoBtn;
    __weak IBOutlet UIButton *dapeiBtn;
    __weak IBOutlet UIButton *fangweiBtn;
    __weak IBOutlet UIButton *pinglunBtn;
    // 基本详情
    __weak IBOutlet UIScrollView *_basicInfoScrollView;
    __weak IBOutlet UIView *_selectView;
    // 第一部分展示酒的图片和按钮
    __weak IBOutlet UIView *_showWineView;
    // 展示酒图片滚动
    __weak IBOutlet UIScrollView *_showWineImageScrollView;
    __weak IBOutlet UIView *showBtnView;
    // 酒图片
    __weak IBOutlet UIImageView *_wineImageView;
    // 酒名称
    __weak IBOutlet UILabel *wineNameLabel;
    // 第二部分
}
@end

#define kImgWH 90

@implementation WinesDetailInfoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   NSLog(@"%@",_showWineImageScrollView.subviews);
    
    self.title = @"产品详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-切片_03-03"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-切片_03"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    CGFloat imageWidth = self.view.frame.size.width;
    
    _basicInfoScrollView.contentSize = CGSizeMake(320, 1880);
    _showWineImageScrollView.contentSize = CGSizeMake(imageWidth * 3, kImageHeight);
    
    UIColor *fontColor = [UIColor colorWithHexString:@"#c9ba9c"];
    [[basicInfoBtn titleLabel] setTextColor:fontColor];
    [[fangweiBtn titleLabel] setTextColor:fontColor];
    [[pinglunBtn titleLabel] setTextColor:fontColor];
    [[dapeiBtn titleLabel] setTextColor:fontColor];
    
    NSLog(@"%f",_showView.frame.size.height);
    
    // 小图片背景
    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(0, 284, 320, 221)];
    sView.backgroundColor = [UIColor clearColor];
//    
//    // 年份
//    PerWineInfoView *yearView = [PerWineInfoView loadFromXib];
//    yearView.frame = CGRectMake(27.5, 27, 70, 80);
//    [sView addSubview:yearView];
//    
//    // 种类
//    PerWineInfoView *categroyView = [PerWineInfoView loadFromXib];
//    categroyView.frame = CGRectMake(125, 27, 70, 80);
//    [sView addSubview:categroyView];
//
//    // 酒精度
//    PerWineInfoView *alcoholView = [PerWineInfoView loadFromXib];
//    alcoholView.frame = CGRectMake(222.5, 27, 70, 80);
//    [sView addSubview:alcoholView];
//
//    // 等级
//    PerWineInfoView *levelView = [PerWineInfoView loadFromXib];
//    levelView.frame = CGRectMake(125, 124, 70, 80);
//    [sView addSubview:levelView];
//    
//    // 净含量
//    PerWineInfoView *weightView = [PerWineInfoView loadFromXib];
//    weightView.frame = CGRectMake(27.5, 124, 70, 80);
//    [sView addSubview:weightView];
//
//    // 适应场合
//    PerWineInfoView *situationView = [PerWineInfoView loadFromXib];
//    situationView.frame = CGRectMake(222.5, 124, 70, 80);
//    [sView addSubview:situationView];
//    
//    [_basicInfoScrollView addSubview:sView];
//    
//    
//    
//    
    
    int columns = 3;
    CGFloat margin = (self.view.frame.size.width - columns * kImgWH) / (columns + 1);
    CGFloat oneY = 65;
    CGFloat oneX = margin;
        for (int i = 0; i < 6; i++) {
        int no = i % 6; // no == [0, 8]
        NSString *imgName = [NSString stringWithFormat:@"icon-切片_0%d", i+1];
            
            if (i == 2) {
                NSLog(@"%@",imgName);
            }
        int col = i % columns;
        int row = i / columns;
        CGFloat x = oneX + col * (kImgWH + margin);
        CGFloat y = oneY + row * (kImgWH + margin);
        
        [self addImg:imgName x:x y:y];
    }


}

#pragma mark 添加表情 icon:表情图片名
- (void)addImg:(NSString *)icon x:(CGFloat)x y:(CGFloat)y
{
    UIImageView *one = [[UIImageView alloc] init];
    one.image = [UIImage imageNamed:icon];
    one.frame = CGRectMake(x, y, kImgWH, kImgWH);
    
    UIView *sview = [[UIView alloc] initWithFrame:CGRectMake(0, 284, 320, 320)];
    [sview addSubview:one];
    [_basicInfoScrollView addSubview:sview];
}





#pragma mark 点击
- (IBAction)basicInfoBtnClick:(UIButton *)sender {
    
    
}
@end
