//
//  DetailWinePicVIew.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "DetailWinePicVIew.h"
#import "WineImageView.h"
#import "DetailAnimationView.h"
#import "WineDetailImages.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioStreamer.h"
#import "ITTImageView.h"

@implementation DetailWinePicVIew
{
    IBOutlet UIScrollView    *_winePicScrollView;
    
    IBOutlet UIPageControl   *_picPageControl;
    
    IBOutlet UIView          *_AnimationView;
    
    IBOutlet UIView          *_AnimationView2;
    
    IBOutlet UIImageView     *_upbackgroundImageView1;
    
    IBOutlet UIImageView     *_downBackgroundImageView1;
    
    IBOutlet UIImageView     *_upbackgroundImageView2;
    
    IBOutlet UIImageView     *_downBackgroundImageView2;
    
    int                       _t;
    BOOL                     _isFirstPic;
    NSArray                  *_picArray;
    BOOL                     _isVoice;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _AnimationView .layer.cornerRadius = 25;
    _AnimationView2 .layer.cornerRadius = 25;
    _isFirstPic = YES;
  //  _picPageControl.numberOfPages =4;
    _winePicScrollView.delegate = self;
    _winePicScrollView.contentSize = CGSizeMake(320, 240);
  //  _wineNameLabel.text = @"法国甘特庄园气泡葡萄酒";
  //  _wineCityLabel.text = @"FAT";
    [self viewAnimation];

    
}

- (void)viewAnimation
{
    [UIView animateWithDuration:10.5f delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        CGRect frame = _upbackgroundImageView1.frame;
        frame.origin.x = frame.origin.x+100;
        _upbackgroundImageView1.frame = frame;
        _downBackgroundImageView1.frame = frame;
        
        frame = _upbackgroundImageView2.frame;
        frame.origin.x = frame.origin.x+100;
        _upbackgroundImageView2.frame = frame;
        _downBackgroundImageView2.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            if(_isFirstPic){
                CGRect frame =CGRectMake(-100, 0, 100, 50);
                _upbackgroundImageView1.frame = frame;
                _downBackgroundImageView1.frame = frame;
                _isFirstPic = NO;
            } else{
                CGRect frame =CGRectMake(-100, 0, 100, 50);
                _upbackgroundImageView2.frame = frame;
                _downBackgroundImageView2.frame = frame;
                _isFirstPic = YES;
            }
            [self viewAnimation];
        }

    }];
}

-(void)timing:(NSTimer *)timer
{
    _t = _t+1;
    CGRect frame = _upbackgroundImageView1.frame;
    frame.origin.x++;
    _upbackgroundImageView1.frame = frame;
    _downBackgroundImageView1.frame = frame;
    
    frame = _upbackgroundImageView2.frame;
    frame.origin.x++;
    _upbackgroundImageView2.frame = frame;
    _downBackgroundImageView2.frame = frame;
    
    if (_t%100 == 0)
    {
        
        if(_isFirstPic){
            CGRect frame =CGRectMake(-100, 0, 100, 50);
            _upbackgroundImageView1.frame = frame;
            _downBackgroundImageView1.frame = frame;
            _isFirstPic = NO;
        } else{
            CGRect frame =CGRectMake(-100, 0, 100, 50);
            _upbackgroundImageView2.frame = frame;
            _downBackgroundImageView2.frame = frame;
            _isFirstPic = YES;
        }
        
    }
    
}

- (void)setImageArray:(NSArray *)imageArray
{
   // if (imageArray.count != 0 ) {
  //      [_winePicScrollView removeAllSubviews];
        _picArray = imageArray;
        _picPageControl.enabled = NO;
        //_picPageControl.defersCurrentPageDisplay = YES;
        NSInteger count = [imageArray count];
//        if (count == 1) {
//            _picPageControl.hidden = YES;
//        }
        _picPageControl.hidesForSinglePage = YES;
        _picPageControl.numberOfPages = count;
        _winePicScrollView.contentSize = CGSizeMake(320*count, 240);
        for(int i = 0; i < count;i++)
        {
            WineDetailImages *winePic = [imageArray objectAtIndex:i];
            WineImageView *imageView = [WineImageView loadFromXib];
            //[imageView.wineImageView setImageWithURL:[NSURL URLWithString:winePic.winePic]];
            imageView.wineImageView.image = [UIImage imageNamed:@"640x480"];
            [imageView.wineImageView loadImage:winePic.winePic placeHolder:[UIImage imageNamed:@"640x480"]];
            imageView.left = i*320;
            [_winePicScrollView addSubview:imageView];
            
        }
    
}

#pragma mark -scrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNumber = scrollView.contentOffset.x/320;
    _picPageControl.currentPage = pageNumber;
    if (_picArray.count !=0) {
        WineDetailImages *wineImage = [_picArray objectAtIndex:pageNumber];
        _wineNameLabel.text = wineImage.wineName;
    }

}

@end
