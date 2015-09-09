//
//  NewsTableViewCell.m
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import "NewsTableViewCell.h"
#import "ITTXibViewUtils.h"
#import "UIImageView+WebCache.h"

@implementation NewsTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)fillCellWithModel:(NewsModel *)model
{
    self.newsTitleLabel.text = model.newsTitle;
   // NSLog(@"****%@",model.newsTitle);
    self.newsDateLabel.text = [self timeFormat:model.newsDate];
    [self.newsImageView loadImage:model
     .newsPic placeHolder:[UIImage imageNamed:@"120x120"]];
}

#pragma mark -timeFormat method
-(NSString *)timeFormat:(NSString *)time
{
    
    NSString *ret;
    NSDate *dateNow = [NSDate date];
    NSDate *date = [NSDate dateWithString:time formate:@"yyyy-MM-dd HH:mm:ss.S"];
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    //NSLog(@"interval %f",interval);
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
   // } else if (interval/172800 <= 1 && days == 1){
     //   ret = [NSString stringWithFormat:@"昨天 %@",hourTime];
    } else {
        ret = [format2 stringFromDate:date];
    }
    return ret;
}

+(NewsTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
