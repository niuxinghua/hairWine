//
//  TemperatureView.m
//  HaierWine
//
//  Created by david on 14/7/15.
//
//

#import "TemperatureView.h"
#import "TemperatureTableViewCell.h"
#import "WineKindTableViewCell.h"

//#define UPTOP 1//滑块指在20度上时的frame.top--
#define UPTOP 4//滑块指在18度上时的frame.top--
#define DOWNTOP 316//滑块指在5度上时的frame.top
//#define CELLHEIGHT 21.0 --
#define CELLHEIGHT 24.0
//#define HIGHDEGREE 20 --
#define HIGHDEGREE 18
#define LOWDEGREE 5
//tableview中cell的高度,滑动一个cell的距离就是1度

@implementation TemperatureView{
    
    IBOutlet UITableView    *_temperatureTableView;
    IBOutlet UITableView    *_wineKindTableView;
    IBOutlet UIView         *_platformView;
    IBOutlet ITTXibView     *_slider;
    IBOutlet ITTXibView     *_redView;
    IBOutlet UILabel        *_displayLabel;
    IBOutlet UIImageView         *_picView;
    IBOutlet UIView         *_gestureView;

    
    NSArray *_data1Array;
    NSArray *_data2Array;
    NSArray *_data3Array;
    NSArray *_topArray;
    NSArray *_picArray;
    NSInteger _whiteLabel;
    NSString *_retStr;
    NSString *_min;
    NSString *_max;
    NSString *_wineKind;
    BOOL _flag;
    BOOL _isMove;//滑动的时候置为yes，在点击酒类的时候置为no
    BOOL _isNotAddArry;
    NSMutableArray *_colorArr;//记录改变颜色的数组
    CGFloat _top; //记录气泡上方的y坐标
    CGFloat _end;//记录气泡下方的y坐标
    BOOL _isOn;//是否点击在滑块上
    CGFloat _touch;//点击时的点
    BOOL _is21;//由于滑动的时候不一定就会正好是21.可能超过这个范围
    BOOL _isMin21;
    CGFloat _dif;//p.y-_touch存贮的差
    
    
    
    WineKindTableViewCell *_selectCell;//被选中抖动的cell
    NSString *_nowTemperature;
    NSTimer *_timer;
    NSInteger _count;//计数器
    BOOL _isShake;
    NSInteger _i;//cell震动一次变化次数
    BOOL _isSplash; //气泡闪

    IBOutlet UIView *_upView;
    IBOutlet UIView *_upSecView;
    IBOutlet UIView *_downView;
    IBOutlet UIView *_downSecView;


    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    _upView.layer.cornerRadius = 6.0;
    _downView.layer.cornerRadius = 6.0;
    
    _downView.hidden = YES;
    _downSecView.hidden = YES;
    _upView.hidden = YES;
    _upSecView.hidden = YES;

    _isSplash = YES;
    _colorArr = [[NSMutableArray alloc]init];
    _min = @"12";
    _max = @"15";
    _wineKind = @"干红葡萄酒";//9.17
    _nowTemperature = @"13";
//    _data1Array = @[@"20°C",@"19°C",@"18℃",@"17℃",@"16℃",@"15℃",@"14℃",@"13℃",@"12℃",@"11℃",@"10℃",@"9℃",@"8℃",@"7℃",@"6℃",@"5℃"];
    //9.2
    _data1Array = @[@"18℃",@"17℃",@"16℃",@"15℃",@"14℃",@"13℃",@"12℃",@"11℃",@"10℃",@"9℃",@"8℃",@"7℃",@"6℃",@"5℃"];
    
    _data2Array = @[@"干红葡萄酒",@"半干红葡萄酒",@"半甜/甜红葡萄酒",@"干白葡萄酒",@"半干白葡萄酒",@"半甜/甜白葡萄酒",@"桃红葡萄酒",@"起泡酒/香槟"];
    _data3Array = @[@"16",@"18",@"12",@"18",@"8",@"16",@"8",@"12",@"5",@"8",@"6",@"14",@"5",@"13",@"5",@"10"];
    _picArray = @[@"controlWine_temperature_narrow_1.png",@"controlWine_temperature_narrow_2.png",@"controlWine_temperature_narrow_3.png",@"controlWine_temperature_narrow_4.png",@"controlWine_temperature_narrow_5.png",@"controlWine_temperature_narrow_6.png",@"controlWine_temperature_narrow_7.png",@"controlWine_temperature_narrow_8.png"];
    
    _temperatureTableView.delegate = self;
    _temperatureTableView.dataSource = self;
    _wineKindTableView.delegate = self;
    _wineKindTableView.dataSource = self;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(move:)];
    [_gestureView addGestureRecognizer:pan];
    //设置气泡初始的位置坐标
   // _top = 146;--
    _top = 122.5;
   // _end = 202;
    _end = 178;
    
//气泡动画
   /*
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        _slider.alpha = 1;
        NSInteger i = 0;
        NSLog(@"i :%d _displayLabel.text %@ _max.integerValue %d _min.integerValue %d",i++,_displayLabel.text,_max.integerValue,_min.integerValue);
    //    if (_displayLabel.text.integerValue > _max.integerValue || _displayLabel.text.integerValue < _min.integerValue) {
            
            _slider.alpha = 0;
            
   //     }
    } completion:^(BOOL finished) {
        _slider.alpha = 1;
    }];
  */
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(typeAnimation) userInfo:nil repeats:YES];
}

-(void)typeAnimation{

    if (self.hidden == NO) {
        _count++;
   //     NSLog(@"i :%d _nowTemperature %@ _max.integerValue %d _min.integerValue %d",i++,_nowTemperature,_max.integerValue,_min.integerValue);
        
        if (_count == 10 * 3) {
            //4秒震动一次
            _isShake = YES;
            _i = 0;
            _count = 0;
        }
        
        if (_isShake) {
            
            _i++;
            [UIView animateWithDuration:0.08 animations:^{
                
                _selectCell.customLabel.frame = CGRectMake(-5, 0, 121, 35);
                
            } completion:^(BOOL finished) {
                //酒种类的震动
                _selectCell.customLabel.frame = CGRectMake(0, 0, 121, 35);
            }];
            if (_i == 3) {
                _isShake = NO;
                _i = 0;

            }
//            if (_count == 20 *3) {
//                
//                _count = 0;
//            }
           
        }
        
        if (_nowTemperature.integerValue <= _max.integerValue && _nowTemperature.integerValue >= _min.integerValue) {
            
            _slider.alpha = 1;
        }
        
        if ((_nowTemperature.integerValue > _max.integerValue || _nowTemperature.integerValue < _min.integerValue)&& _count%10 == 0 ) {
        
            if (_isSplash) {
                
                [UIView animateWithDuration:1 animations:^{
                    _slider.alpha = 0;
                }];
                
            } else {
            
                [UIView animateWithDuration:1 animations:^{
                    _slider.alpha = 1;
                }];
                
            }
            _isSplash = !_isSplash;

        }
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  //  NSLog(@"begin");
  //  NSLog(@"_touch %f",_touch);
    _isOn = NO;
    _top = _slider.top;
    _end = _slider.top + _slider.height;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:_gestureView];
    _touch = currentLocation.y;
    
   // NSLog(@"touchbegin----_top %f, end %f",_top,_end);
   // NSLog(@"touchbegin point ----_touch %f",_touch);

    if (_touch > _top && _touch < _end) {
        _isOn = YES;
    }
//    NSLog(@"--begin-------");
    
}
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    _isOn = NO;
//    _top = _slider.top;
//    _end = _slider.top + _slider.height;
//    
//  //  NSLog(@"touchend----_top %f, end %f",_top,_end);
//    NSLog(@"--end-------");
//}


-(void)move:(UIPanGestureRecognizer *)pan{
    _isMove = YES;
 //   NSLog(@"--move-------");
    CGPoint p = [pan locationInView:_gestureView];
    _dif = p.y-_touch;
//    if (_dif == 21 ) {--
    if (_dif == 24 ) {
        _is21 = YES;
//    }else if (_dif == -21){--
      }else if (_dif == -24){
        _isMin21 = NO;
    }
 //   BOOL temp = ((p.y-_touch) == 21)?YES:NO;
//    NSLog(@"isone:%hhd,temp:%hhd,jjj:%f",_isOn,temp,p.y-_touch);
    //if (_isOn && (_is21 ||(_is21 == NO && _dif > 21))) {--
    if (_isOn && (_is21 ||(_is21 == NO && _dif > 24))) {
     //   if (_slider.top >= DOWNTOP-20) {--
        if (_slider.top >= DOWNTOP-24) {
    //        NSLog(@"++++++%f",p.y-_touch);
            _slider.top = DOWNTOP;
            _touch = [pan locationInView:_gestureView].y;
        } else {
      //      NSLog(@"++++++%f",p.y-_touch);
      //      _slider.top += 21;--
              _slider.top += 24;
            _touch = [pan locationInView:_gestureView].y;
        }
        _top = _slider.top;
        _end = _slider.top + _slider.height;
  //  }else if(_isOn && (_isMin21 ||(_isMin21 == NO && _dif < -21))){--
        }else if(_isOn && (_isMin21 ||(_isMin21 == NO && _dif < -24))){
     //   NSLog(@"++++++%f",p.y-_touch);
     //   NSLog(@"_slider.top:@%f,DOWNTOP:@%d",_slider.top,UPTOP);
        if (_slider.top <= UPTOP) {
     //       NSLog(@"_slider.top:@%f,DOWNTOP:@%d",_slider.top,DOWNTOP);
            _slider.top = UPTOP;
            _touch = [pan locationInView:_gestureView].y;
            
        } else {
     //       NSLog(@"++++++%f",p.y-_touch);
          //  _slider.top -= 21;--
            _slider.top -= 24;
            _touch = [pan locationInView:_gestureView].y;
            
        }
        _top = _slider.top;
        _end = _slider.top + _slider.height;
    }
    _is21 = NO;
    _displayLabel.text = [NSString stringWithFormat:@"%d",[self topToDegree:_slider.top]] ;
    _nowTemperature = _displayLabel.text;//8.26
    _whiteLabel = [self topToDegree:_slider.top];
    [_temperatureTableView reloadData];
    
   // NSLog(@"tttttt %f",_slider.top);

}
/*
-(void)move:(UIPanGestureRecognizer *)pan{
    _isMove = YES;
    CGPoint p = [pan translationInView:self];
    if (_slider.top >=UPTOP && _slider.top <= DOWNTOP) {
//        if (p.y > 4) {
//            _slider.top += 21;
//        }else if(p.y < -4){
//            _slider.top -= 21;
//        }
        _slider.top += p.y;
    }
    if (_slider.top < UPTOP) {
        _slider.top = UPTOP;
    }
    if (_slider.top > DOWNTOP) {
        _slider.top = DOWNTOP;
    }
    [pan setTranslation:CGPointMake(0, 0) inView:_platformView];
//    NSLog(@"top : %f degree:%d (top-10)/21:%d",_slider.top,[self topToDegree:_slider.top],(NSInteger)(_slider.top-10)/21);
    _displayLabel.text = [NSString stringWithFormat:@"%d",[self topToDegree:_slider.top]] ;
    _whiteLabel = [self topToDegree:_slider.top];
    [_temperatureTableView reloadData];

}
*/
#pragma mark - degreeToTop method
-(CGFloat)degreeToTop:(NSInteger)degree
{
    if (degree == HIGHDEGREE) {
        return UPTOP;
    }else if(degree == LOWDEGREE){
        return DOWNTOP;
    }else{
        //return (20-degree)*21-0.5;--
        //9.5+(20-degree)*21-10.5;
       // return (20-degree)*24-0.5;--
        return (18-degree)*24;
    }
}

-(NSInteger)topToDegree:(CGFloat)top
{
//    if (top < 10) {--1+9
    if (top < 13) { //4+9
    //    return 20;--
        return 18;
    }else if(top > 303){
        return 5;
    }else{
    //    return HIGHDEGREE-(top-10)/21;--
        return HIGHDEGREE-(top-10)/24;
    }
    
}
#pragma mark - colorRemark method
-(void)colorRemark:(NSInteger)num
{
    //以下注释不要删除
    //20  19  18  17  16  15  14  13 12 11 10  9   8   7   6   5
    //0   1   2   3   4   5   6   7  8  9  10  11  12  13  14  15
    [_colorArr removeAllObjects];
    switch (num) {
        case 0:
        {
            [_colorArr addObjectsFromArray:@[@"2",@"3",@"4"]];
        }
            break;
        case 1:
        {
            [_colorArr addObjectsFromArray:@[@"2",@"3",@"4",@"5",@"6",@"7",@"8"]];
        }
            break;
        case 2:
        {
            [_colorArr addObjectsFromArray:@[@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
        }
            break;
        case 3:
        {
            [_colorArr addObjectsFromArray:@[@"8",@"9",@"10",@"11",@"12"]];
        }
            break;
        case 4:
        {
            [_colorArr addObjectsFromArray:@[@"12",@"13",@"14",@"15"]];
        }
            break;
        case 5:
        {
            [_colorArr addObjectsFromArray:@[@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"]];
        }
            break;
        case 6:
        {
            [_colorArr addObjectsFromArray:@[@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];
        }
            break;
        default:
        {
            [_colorArr addObjectsFromArray:@[@"10",@"11",@"12",@"13",@"14",@"15"]];
        }
            break;
    }
}
#pragma mark - tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 200) {
        return 46;//42.75
    }else{
       // return 21;
        return 24;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100 ) {
        return _data1Array.count;
    }else{
        return _data2Array.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {
        static NSString *cellId = @"TemperatureTableViewCellId";
        TemperatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [TemperatureTableViewCell loadCell];
                      //  cell = [[[NSBundle mainBundle]loadNibNamed:@"TemperatureTableViewCell" owner:self options:nil]lastObject];
            _flag = 1;
        }
        cell.comsumerLabel.text = _data1Array[indexPath.row];
        cell.comsumerLabel.alpha = 0.2;
  //      if ((20-_whiteLabel) == indexPath.row){
        if ((20-_whiteLabel) - 2 == indexPath.row){
            cell.comsumerLabel.text =nil;
        }
        if (_flag == 1 && _isMove ==NO) {
            if (_isNotAddArry == NO) {
                [_colorArr addObjectsFromArray:@[@"5",@"6",@"7",@"8"]];//只用加一次数组
            }
    //        if (indexPath.row == 7) {
            if (indexPath.row == 5) {  //7-2
                cell.comsumerLabel.text =nil;
            }
   //         if (indexPath.row == 5 ||indexPath.row == 6 ||
   //             indexPath.row == 8 ) {
            if (indexPath.row == 3 ||indexPath.row == 4 ||
                indexPath.row == 6 ) {
                cell.comsumerLabel.alpha = 1;
            
            }
            _isNotAddArry = YES;
        }
        
        //选择酒品改变颜色
        if (_colorArr.count != 0) {
            for (NSString* num in _colorArr) {
            //    NSLog(@"_colorArr++:%@",num);
                NSInteger i = num.integerValue;
           //     if (indexPath.row == i) {--
                if (indexPath.row + 2 == i) {
                    cell.comsumerLabel.alpha = 1;
                }
                //else{
                
//cell.comsumerLabel.text = _data1Array[indexPath.row];                }
            }
            if (_isMove == NO) {
                //防止当移动的指针度数(内容置空)，出现在适宜饮用温度中，温度值依然为空
                cell.comsumerLabel.text = _data1Array[indexPath.row];
                
                NSString *num2 = _colorArr[_colorArr.count/2];
              //  NSLog(@"num2:%@,_colorArr.count:%d\n_colorArr[_colorArr.count/2]:%@",num2,_colorArr.count,_colorArr[_colorArr.count/2]);
                NSInteger i2 = num2.integerValue;
             //   NSLog(@"indexPath.row:%d",indexPath.row);
             //   if (indexPath.row == i2) {--
                if (indexPath.row + 2 == i2) {
                    
                    cell.comsumerLabel.text = nil;
                    
                }
            }
        }
        _flag = 0;
        return cell;
    }else if(tableView.tag == 200){
        static NSString *cellId = @"WineKindTableViewCellId";
        WineKindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [WineKindTableViewCell loadCell];
            if (indexPath.row == 2) {
                cell.customLabel.textColor = [UIColor whiteColor];
                _selectCell = cell;
                _selectCell.textLabel.textColor = [UIColor yellowColor];
            }

        //    cell = [[[NSBundle mainBundle]loadNibNamed:@"WineKindTableViewCell" owner:self options:nil]lastObject];
        }
        cell.customLabel.text = _data2Array[indexPath.row];
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _downView.hidden = YES;
    _downSecView.hidden = YES;
    _upView.hidden = YES;
    _upSecView.hidden = YES;
    
    if (indexPath.row == 0 || indexPath.row ==1) {
        
        _downView.hidden = YES;
        _downSecView.hidden = YES;
        _upView.hidden = NO;
        _upSecView.hidden = NO;
    }
    
    _isMove = NO;
    //记录颜色
    [self colorRemark:indexPath.row];
    //对于初始情况的处理
    if (indexPath.row != 2) {
        WineKindTableViewCell *cell2 = (WineKindTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell2.customLabel.textColor = [UIColor colorWithRed:120/255.0f green:109/255.0f blue:115/255.0f alpha:1];
    }
    _redView.top = 27;
    _redView.height = 0;
  //  _picView.image = nil;
    _picView.image = [UIImage imageNamed: _picArray[indexPath.row]];
    WineKindTableViewCell *cell = (WineKindTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    _selectCell = cell;
    _isShake = YES;
    _count = 0;
    cell.customLabel.textColor = [UIColor whiteColor];
    _wineKind = cell.customLabel.text;

        _min = _data3Array[indexPath.row*2];
        _max = _data3Array[indexPath.row*2+1];
    
    
        CGFloat top = [self degreeToTop:_max.integerValue]+28;
        CGFloat height =[self degreeToTop:_min.integerValue]-top+28;
    
        /*
        [UIView animateWithDuration:0.4 animations:^{
            _slider.top = [self degreeToTop:(_min.integerValue+_max.integerValue)/2];
            _redView.top = top;
            _redView.height = height;
        //    NSLog(@"top:%f height:%f _slider.top:%f",top,height,_slider.top);
        }];
    */
    //8.28
    [UIView animateWithDuration:0.3 animations:^{
        
        _slider.top = [self degreeToTop:(_min.integerValue+_max.integerValue)/2];
        _redView.top = top;
        _redView.height = height;
        
    } completion:^(BOOL finished) {
        
        _top = _slider.top;
        _end = _slider.top + _slider.height;
        
        if (indexPath.row == 4 ||indexPath.row == 6 ||indexPath.row == 7 ) {
            _downView.hidden = NO;
            _downSecView.hidden = NO;
            _upView.hidden = YES;
            _upSecView.hidden = YES;
        }
        
    }];
    
    //8.28
    
 //   NSLog(@"++%f",_slider.top);
    _displayLabel.text = [NSString stringWithFormat:@"%d",[self topToDegree:_slider.top]] ;
    _nowTemperature = _displayLabel.text;//8.26
    //改变颜色
    [_temperatureTableView reloadData];
   // [_colorArr removeAllObjects];//reloadData是异步加载
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 //   NSLog(@"%d",indexPath.row);
    WineKindTableViewCell *cell = (WineKindTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.customLabel.textColor = [UIColor colorWithRed:120/255.0f green:109/255.0f blue:115/255.0f alpha:1];
}

-(IBAction)btnClick:(id)sender
{
    _retStr = [NSString stringWithFormat:@"%@°~%@°",_min,_max];
    [_delegate suitableTemperature:_retStr andWindKind:_wineKind];
 //   [_delegate complite:[self topToDegree:_slider.top]];
    [_delegate complite:[self topToDegree:_slider.top] :YES];
//    [UIView animateWithDuration:0.7 animations:^{
//        self.superview.alpha = 0.f;
//        
//    }];
  //  self.hidden = YES;
  //  [self removeFromSuperview];
  //  NSLog(@"酒品%@",_wineKind);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(IBAction)cancleClick:(id)sender{
    
    [_delegate complite:[self topToDegree:_slider.top] :NO];
  //  [_delegate complite:9999];//回首页
    
    
}
@end
