//
//  MainView.h
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "ITTXibView.h"

@interface MainSubView : ITTXibView
@property(nonatomic,strong)IBOutlet UILabel     *titleLabel;
@property(nonatomic,strong)IBOutlet UILabel     *title2Label;

@property(nonatomic,strong)IBOutlet ITTImageView *picImageView;
@property(nonatomic,strong)IBOutlet UILabel     *subscribeLabel;
@property(nonatomic,strong)IBOutlet UILabel     *subtitle1Label;
@property(nonatomic,strong)IBOutlet UILabel     *date1Label;
@property(nonatomic,strong)IBOutlet UILabel     *subtitle2Label;
@property(nonatomic,strong)IBOutlet UILabel     *date2Label;
@property(nonatomic,strong)IBOutlet ITTImageView * picImage1View;
@property(nonatomic,strong)IBOutlet ITTImageView *picImage2View;

@property(nonatomic,weak)UIViewController *controller;
@property(nonatomic,strong)IBOutlet UIButton *btn1;
@property(nonatomic,strong)IBOutlet UIButton *btn2;
@property(nonatomic,strong)IBOutlet UIButton *btn3;

@end
