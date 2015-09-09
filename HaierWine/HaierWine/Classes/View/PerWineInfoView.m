//
//  PerWineInfoView.m
//  HaierWine
//
//  Created by Tongyanlong on 14-7-4.
//
//

#import "PerWineInfoView.h"
#define kImgWidthHeight 90
#define kWidth 320;

@interface PerWineInfoView ()
{
    __weak IBOutlet UIImageView *_bgImageView;
    
}

@end

@implementation PerWineInfoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}
//+ (void)setImageFrame
//{
//    int columns = 2;
//    CGFloat margin = (kWidth - columns * kImgWidthHeight) / (columns + 1);
//    CGFloat oneY = 65;
//    CGFloat oneX = margin;
//    
//    // 3.创建所有的表情
//    for (int i = 0; i < 6; i++) {
//        int no = i % 6; // no == [0, 8]
//        NSString *imgName = [NSString stringWithFormat:@"01%d.png", no];
//        int col = i % columns;
//        int row = i / columns;
//        CGFloat x = oneX + col * (kImgWidthHeight + margin);
//        CGFloat y = oneY + row * (kImgWidthHeight + margin);
//        
//        [sView addImg:imgName x:x y:y];
//    }
//
//}
@end
