//
//  MyLoveWineTableViewCell.m
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import "MyLoveWineTableViewCell.h"
#import "ITTXibViewUtils.h"

@interface MyLoveWineTableViewCell ()
{
    UIImageView *_checkImageView;
    BOOL         _isChecked;
    IBOutlet UIView *_sepertorLine;
    
    
}

@end

@implementation MyLoveWineTableViewCell

- (void)awakeFromNib
{
   // self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+(MyLoveWineTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCheckImageViewCenter:(CGPoint)point alpha:(CGFloat)alpha animate:(BOOL)animate withLeft:(CGFloat)left;
{
    if (animate) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        _checkImageView.center = point;
        _checkImageView.alpha = alpha;
        _sepertorLine.left = left;
        [UIView commitAnimations];
    } else {
        _checkImageView.center = point;
        _checkImageView.alpha = alpha;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    //  [super setEditing:editing animated:animated];
    if (self.editing == editing) {
        return;
    }
    [super setEditing:editing animated:animated];
    if (editing) {
        
        self.backgroundView = [[UIView alloc]init];
        if (_checkImageView == nil) {
            _checkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"multiple_unSelected_imag"]];
            _checkImageView.size = CGSizeMake(18, 18);
            [self addSubview:_checkImageView];
        }
        [self setChecked:_isChecked];
        _checkImageView.alpha = 0;
        _checkImageView.center = CGPointMake(-CGRectGetWidth(_checkImageView.frame) * 0.5,CGRectGetHeight(self.bounds) * 0.5);
        [self setCheckImageViewCenter:CGPointMake(25, CGRectGetHeight(self.bounds) * 0.5) alpha:1.0 animate:animated withLeft:-20];
    } else {
        _sepertorLine.left = 13;
        _isChecked = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = nil;
        if (_checkImageView) {
            [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(_checkImageView.frame) * 0.5,
													  CGRectGetHeight(self.bounds) * 0.5) alpha:0.0 animate:animated withLeft:13];
        }
    }
}

- (void)setChecked:(BOOL)checked
{
    if (checked) {
        _checkImageView.image = [UIImage imageNamed:@"multiple_Selected_imag"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    } else {
        _checkImageView.image = [UIImage imageNamed:@"multiple_unSelected_imag"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    
    _isChecked = checked;
}

@end
