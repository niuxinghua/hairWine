//
//  CityListViewController.m
//  HaierWine
//
//  Created by 张作伟 on 14-7-29.
//
//

#import "CityListViewController.h"

@interface CityListViewController ()
{
    IBOutlet UITableView  *_cityTableView;
    NSMutableDictionary        *_citysDict;
    NSMutableArray        *_keysArray;
}

@end

@implementation CityListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getCityData];
    [_cityTableView reloadData];
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    _citysDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    _keysArray = [[NSMutableArray alloc]init];
    
    [_keysArray addObjectsFromArray:[[_citysDict allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}

#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keysArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keysArray count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    //titleLabel.backgroundColor = [UIColor clearColor];
    //titleLabel.textColor = [UIColor blackColor];
    //titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *key = [_keysArray objectAtIndex:section];
    titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keysArray objectAtIndex:section];
    NSArray *citySection = [_citysDict objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keysArray objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = [[_citysDict objectForKey:key] objectAtIndex:indexPath.row];
  //  NSLog(@"%@",[[_citysDict objectForKey:key] objectAtIndex:indexPath.row]);
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *key = [_keysArray objectAtIndex:indexPath.section];
    NSString *cityName = [[_citysDict objectForKey:key] objectAtIndex:indexPath.row];
 //   [_delegate selectedCity:cityName];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - navButton

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
