//
//  VegetableView.m
//  HaierWine
//
//  Created by isoftstone on 14-7-10.
//
//

#import "VegetableView.h"
#import "ITTImageView.h"
@interface VegetableView ()

{
    IBOutlet UILabel     *_vegetableLabel;
    IBOutlet UIImageView *_quoteImageView;
    IBOutlet UIButton    *_moreButton;
             UIView      *_platformView;
    
    CGFloat _originalHeight;
    CGFloat _changeHeight;
    CGFloat _height;//总高
}

@end

@implementation VegetableView

- (void)awakeFromNib
{
//    self.height = 432;
//    NSInteger space = 10; //图片间隔
//
//    for (int i = 0; i < 2; i++) {
//        //假设图片width 164 height 225
//        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((320-300)/2, space+(space+150)*i+44+50, 300, 150)];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"foot_image%d.jpg",i+1]];
//        [self addSubview:imageView];
//    }
    _originalHeight = _vegetableLabel.height;

}

- (void)layoutOriginViewWithArray:(NSArray *)data andTitle:(NSString *)title
{
  //  title = str;
    //CGFloat labelHeight;
    [self setTitleWith:title];
   // _quoteImageView.frame = CGRectMake(270, 15+labelHeight, 30, 30);
    NSInteger count = data.count;
    NSInteger space = 10; //图片间隔
    _height = space+(space+147)*count+44 + _originalHeight+30;   //总的height 30是加上的按钮
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _height);
    _platformView = [[UIView alloc]initWithFrame:CGRectMake((320-294)/2, space+44+_originalHeight+30, 294, 147*count)];

//    _platformView.backgroundColor = [UIColor yellowColor];

    [self addSubview:_platformView];
    
    for (int i = 0; i < count; i++) {
        //假设图片width 300 height 150
        //294*147
//        ITTImageView  *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake((320-294)/2, space+(space+147)*i+44+_originalHeight+30, 294, 147)];
        
          ITTImageView  *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(0,(space+147)*i, 294, 147)];
        
//        imageView.backgroundColor = [UIColor redColor];
//        [imageView loadImage:data[i]];
        imageView.image = [UIImage imageNamed:@"588x294"];
        [imageView loadImage:data[i] placeHolder:[UIImage imageNamed:@"588x294"]];
       // [self addSubview:imageView];
        [_platformView addSubview:imageView];
    }

}

- (CGFloat)setTitleWith:(NSString *)title
{
    
        // title = @"这款黑比诺来自圣安东尼奥古,拥有深宝石红色并带紫色.他的酒香浓郁,带有成熟覆盆子,樱桃,草莓的芳香,还夹杂着咖啡和可可的味道,入口果香浓郁,单宁细滑柔软这款黑比诺来自圣安东尼奥古,拥有深宝石红色并带紫色.他的酒香浓郁,带有成熟覆盆子,樱桃,";
    NSString *str = [NSString stringWithFormat:@"       %@",title];
        UIFont *font = [UIFont systemFontOfSize:14];
        CGFloat labelHeight = [UILabel layoutLabelHeightText:str font:font width:245];
   // NSLog(@"HeightHeight %f",labelHeight);
    //HeightHeight 50.105999
        if (labelHeight < 51) {
            _moreButton.hidden = YES;
            [_vegetableLabel setFrame:CGRectMake(39, 28, 245, labelHeight+5)];
            _quoteImageView.top = _quoteImageView.top+labelHeight - 51;
            
        }
        //   _vegetableLabel.height = labelHeight;
    
    if (title != NULL) {
        
        _vegetableLabel.text = str;

    }
    
        return labelHeight;
    
   
}

- (IBAction)sizeLabel:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    _moreButton.selected = !_moreButton.selected;
    // btn.selected = !btn.selected;
   // NSLog(@"***%d",btn.selected);
    if (_moreButton.selected) {
        CGFloat labelHeight = [UILabel layoutLabelHeightText:_vegetableLabel.text font:[UIFont systemFontOfSize:14] width:245];
      //  NSLog(@"labelHeight---%f",labelHeight);
        _changeHeight = labelHeight - _originalHeight;
       // NSLog(@"_changeHeight %f",labelHeight);
        _moreButton.top += _changeHeight;
        _quoteImageView.top += _changeHeight;
        _platformView.top += _changeHeight;
        // _wineContentLabel.height = labelHeight;
        if (labelHeight < 51) {
            _moreButton.hidden = YES;
            return;
        }
        [_vegetableLabel setFrame:CGRectMake(39, 28, 245, labelHeight+5)];
    //    self.height = self.height +labelHeight-62;
        self.height = _height + _changeHeight+5;
    } else {
        _vegetableLabel.height = 51;
        _moreButton.top -= _changeHeight;
        _quoteImageView.top -= _changeHeight;
        _platformView.top -= _changeHeight;
    //    self.height = 208;
        self.height = _height;
    }
 //   [_delegate refreshUI:self.height];
    [_delegate refreshVegetableView:self.height];
}

@end
