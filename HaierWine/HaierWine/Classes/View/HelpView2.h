//
//  HelpView2.h
//  HaierWine
//
//  Created by david on 14/8/27.
//
//

#import "ITTXibView.h"

@interface HelpView2 : ITTXibView
@property(nonatomic,weak)id delegate;
@property(nonatomic,strong)IBOutlet UIImageView *image1;
@property(nonatomic,strong)IBOutlet UIImageView *image2;
@property(nonatomic,strong)IBOutlet UIImageView *image3;
@property(nonatomic,strong)IBOutlet UILabel *label1;
@property(nonatomic,strong)IBOutlet UILabel *label2;
@property(nonatomic,strong)IBOutlet UILabel *label3;
@property(nonatomic,strong)IBOutlet UILabel *labelText1;
@property(nonatomic,strong)IBOutlet UILabel *labelText2;
@property(nonatomic,strong)IBOutlet UILabel *labelText3;
@property(nonatomic,strong)IBOutlet UIButton *button;
@end
