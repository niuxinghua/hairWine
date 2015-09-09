//
//  MyBrowseViewController.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import "MyBrowseViewController.h"
#import "MyLoveWineTableViewCell.h"
#import "MyLoveWine.h"
#import "PKRevealController.h"

@interface MyBrowseViewController ()
{
    NSArray              *_dataArray;
    
    IBOutlet UITableView *_myBrowseTableView;
    
}
@end

@implementation MyBrowseViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    NSMutableArray *initArray = [[NSMutableArray alloc]init];
    for(int i = 0; i<10;i++){
        MyLoveWine *myloveWine = [[MyLoveWine alloc]init];
        myloveWine.wineName = @"法国干红葡萄酒";
        [initArray addObject:myloveWine];
    }
    _dataArray = initArray;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"winePrice";
    MyLoveWineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [MyLoveWineTableViewCell cellFromNib];
    }
    cell.editImageViewSelected.hidden = YES;
    cell.editImageView.hidden = YES;
    MyLoveWine *myLoveWine = [_dataArray objectAtIndex:indexPath.row];
    //NSLog(@"_dataArray==%@",_dataArray);
    cell.wineNameLabel.text = myLoveWine.wineName;
    [cell.wineImageView loadImage:myLoveWine.winePic placeHolder:[UIImage imageNamed:@"120x120"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}


#pragma mark - buttonClick

- (IBAction)backButton:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
    
}

- (IBAction)editButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    [_myBrowseTableView setEditing:button.selected animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
