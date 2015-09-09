//
//  MainView.m
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "MainSubView.h"
#import "UILabel+ITTAdditions.h"
#import "NewsViewController.h"
#import "ProfessionalViewController.h"
#import "ExperienceViewController.h"
#import "DetailViewController.h"
#import "DetailExperienceViewController.h"
#import "DetailProfessionalViewController.h"
//@interface MainSubView ()
//{
//    CGFloat _titleLabelHeight;
//}
//
//@end

@implementation MainSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)gotoTable:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.superview.tag) {
        case 400:
            //新闻
        {
            NewsViewController *newsVc = [[NewsViewController alloc]init];
            newsVc.isHomePage = YES;
            [_controller.navigationController pushViewController:newsVc animated:YES];
        }
            break;
        case 401:
            //专业品鉴
        {
         //   NSLog(@"专业");
            ProfessionalViewController *proVc = [[ProfessionalViewController alloc]init];
            proVc.isHomePage = YES;
            [_controller.navigationController pushViewController:proVc animated:YES];
        }
            break;
        default:
            //品鉴心得
        {
            ExperienceViewController *expVc = [[ExperienceViewController alloc]init];
            expVc.isHomePage = YES;
            [_controller.navigationController pushViewController:expVc animated:YES];
        }
            break;
    }
    
}
-(IBAction)gotoDetail:(id)sender
{
   // NSLog(@"123");
    UIButton *btn = (UIButton *)sender;
    switch (btn.superview.tag) {
        case 400:
            //新闻
        {
            DetailViewController *detailVc = [[DetailViewController alloc]init];
            detailVc.newsId = [NSString stringWithFormat:@"%d",btn.tag];
            detailVc.type = NewsDetailType;
            [_controller.navigationController pushViewController:detailVc animated:YES];
        }
            break;
        case 401:
            //专业品鉴
        {
            /*
            DetailProfessionalViewController *detailVc = [[DetailProfessionalViewController alloc]init];
            detailVc.ProfessionalId = [NSString stringWithFormat:@"%d",btn.tag];
            [_controller.navigationController pushViewController:detailVc animated:YES];
             */
            DetailViewController *detailVc = [[DetailViewController alloc]init];
            detailVc.newsId = [NSString stringWithFormat:@"%d",btn.tag];
            detailVc.type = ProfessionalDetailType;
            [_controller.navigationController pushViewController:detailVc animated:YES];
        }
            break;
        default:
            //品鉴心得
        {
            /*
            DetailExperienceViewController *detailVc = [[DetailExperienceViewController alloc]init];
            detailVc.ExperienceId = [NSString stringWithFormat:@"%d",btn.tag];
            [_controller.navigationController pushViewController:detailVc animated:YES];
             */
            DetailViewController *detailVc = [[DetailViewController alloc]init];
            detailVc.newsId = [NSString stringWithFormat:@"%d",btn.tag];
            detailVc.type = ExperienceDetailType;
            [_controller.navigationController pushViewController:detailVc animated:YES];
        }
            break;
    }
    
}
//- (void)setTitleLabel:(UILabel *)titleLabel
//{
// 
//    //这个函数什么时候调用？self.titleable时候调用
//  _titleLabelHeight = [UILabel layoutLabelWidthWithText:titleLabel.text font:[UIFont systemFontOfSize:18] height:300];
//    self.title2Label.left = _titleLabelHeight+4;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
