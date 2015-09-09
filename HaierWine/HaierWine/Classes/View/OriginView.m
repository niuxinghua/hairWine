//
//  OriginView.m
//  HaierWine
//
//  Created by david on 14/7/9.
//
//

#import "OriginView.h"
#import "ITTImageView.h"

@implementation OriginView

- (void)awakeFromNib
{
//    self.height = 20;
//    imageArray = [[NSMutableArray alloc]init];
//    NSInteger space = 10; //图片间隔
//    for (int i = 0; i < 2; i++) {
//        //假设图片width 164 height 225
//        ITTImageView  *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake((320-300)/2, space+(space+150)*i+44+50, 300, 150)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"vertical_image%d.jpg",i+1]];
//        [self addSubview:imageView];
//        [imageArray addObject:imageView];
//    }

}

- (void)layoutOriginViewWithArray:(NSArray *)data
{
   
    NSInteger count = data.count;

    NSInteger space = 10; //图片间隔
    NSInteger height = space+(space+292)*count+44+30;   //总的height
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, space+(space+290)*count+30, 320, 44)];
    
    if (count != 0) {
        
        [label setText:@"*本数据由建发美酒汇提供"];

    }
    
    label.textColor = [UIColor colorWithRed:201/255.0 green:168/255.0 blue:158/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:14.0];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    for (int i = 0; i < count; i++) {
        //假设图片width 200 height 225
        //165*220
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake((320-212)/2, space+(space+290)*i-1+30, 212, 292)];
    //    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake((320-167)/2, space+(space+220)*i+43, 167, 222)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 1;
        [self addSubview:bgView];
        
      ITTImageView  *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake((320-210)/2, space+(space+290)*i+30, 210, 290)];
      //ITTImageView  *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake((320-165)/2, space+(space+220)*i+30, 165, 220)];
        imageView.userInteractionEnabled = YES;
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
        imageView.tag = 100+i;
        [imageView addGestureRecognizer:tap];
        imageView.image = [UIImage imageNamed:@"420x580"];
        [imageView loadImage:data[i] placeHolder:[UIImage imageNamed:@"420x580"]];
        [self addSubview:imageView];
    }
}

-(void)tapTheImageView:(UIPanGestureRecognizer *)pan{
    

   // NSLog(@"*************%d",pan.view.tag-100);
    [_delegate largeImage:pan.view.tag-100];

    
}

@end
