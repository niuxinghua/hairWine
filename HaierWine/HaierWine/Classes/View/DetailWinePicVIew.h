//
//  DetailWinePicVIew.h
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "ITTXibView.h"
#import "AudioStreamer.h"

@protocol DetailWinePicVIewDelegate <NSObject>

- (void)isPlayVoice:(BOOL)isPlay;

@end

@interface DetailWinePicVIew : ITTXibView<UIScrollViewDelegate>
{
   // AudioStreamer            *streamer;

}
@property (strong, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *wineCityLabel;
@property (strong, nonatomic) IBOutlet UILabel *wineTemperarureLabel;
@property (weak, nonatomic) id <DetailWinePicVIewDelegate> delegate;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)NSString *voiceURL;

@end
