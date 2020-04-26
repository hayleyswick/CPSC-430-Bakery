//
//  iPadLogViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadLogViewController.h"

@interface iPadLogViewController ()

@end

@implementation iPadLogViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Log" image:[UIImage imageNamed:@"notebook.png"] tag:1];
        preUpdate = [NSArray arrayWithArray:[[OrderManager sharedInstance] orders]];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Paul's Bakery Batter Calculator";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
-(void)viewDidAppear:(BOOL)animated {
    [OrderManager sharedInstance].delegate = self;
    [[OrderManager sharedInstance] fetchOrders];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)orderDataDidUpdate:(NSArray *)orders {
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *removeIndexPaths = [[NSMutableArray alloc] init];
    for (int i=0; i < orders.count; i++) {
        if (![preUpdate containsObject:[orders objectAtIndex:i]]) {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    for (int i=0; i < preUpdate.count; i++) {
        if (![orders containsObject:[preUpdate objectAtIndex:i]]) {
            [removeIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    preUpdate = [NSArray arrayWithArray:orders];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[OrderManager sharedInstance] orders].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogEntryCell";
    LogEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogEntryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:@"M/d/yyyy H:mm a"];
    
    Order *o = [[[OrderManager sharedInstance] orders] objectAtIndex:indexPath.row];
    cell.orderNumberLabel.text = [NSString stringWithFormat:@"Order Number %d", o.orderNumber];
    cell.dateLabel.text = [formatter stringFromDate:o.orderDate];
    cell.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", o.customer.firstname, o.customer.lastname];
    cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!detailVC) {
        detailVC = [[iPadLogDetailViewController alloc] initWithNibName:@"iPadLogDetailViewController" bundle:nil];
        detailVC.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:detailVC animated:YES completion:nil];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
