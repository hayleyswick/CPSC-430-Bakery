//
//  iPadSelectCustomerViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadSelectCustomerViewController.h"

@interface iPadSelectCustomerViewController ()

@end

@implementation iPadSelectCustomerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        preUpdate = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Select Customer"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New Customer" style:UIBarButtonItemStylePlain target:self action:@selector(transitionToAddNewCustomerView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated {
    [CustomerManager sharedInstance].delegate = self;
    [[CustomerManager sharedInstance] fetchCustomerData];
}
-(void)customerDataDidUpdate:(NSArray *)customers {
    
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *removeIndexPaths = [[NSMutableArray alloc] init];
    for (int i=0; i < customers.count; i++) {
        if (![preUpdate containsObject:[customers objectAtIndex:i]]) {
            NSLog(@"Will insert at index: %d", i);
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    for (int i=0; i < preUpdate.count; i++) {
        if (![customers containsObject:[preUpdate objectAtIndex:i]]) {
            NSLog(@"Will remove at index: %d", i);
            [removeIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    preUpdate = [NSArray arrayWithArray:customers];
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
    return [[CustomerManager sharedInstance] customers].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomerViewCell";
    CustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomerTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Customer *c = [[[CustomerManager sharedInstance] customers] objectAtIndex:indexPath.row];
    
    cell.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", c.firstname, c.lastname];
    cell.phoneNumberLabel.text = c.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}
-(void)transitionToAddNewCustomerView {
    if (!editCustomerView) {
        editCustomerView = [[iPadEditCustomerViewController alloc] initWithNibName:@"iPadEditCustomerViewController" bundle:nil];
    }
    [editCustomerView setViewMode:customerEditModeAdd];
    [self.navigationController pushViewController:editCustomerView animated:YES];
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
    if (!editOrderView) {
        editOrderView = [[iPadEditOrderViewController alloc] initWithNibName:@"iPadEditOrderViewController" bundle:nil];
    }
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [editOrderView setSelectedCustomer:[[[CustomerManager sharedInstance] customers] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:editOrderView animated:YES];
}


@end
