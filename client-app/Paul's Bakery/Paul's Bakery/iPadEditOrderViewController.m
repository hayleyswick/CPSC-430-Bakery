//
//  iPadEditOrderViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/5/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadEditOrderViewController.h"

@interface iPadEditOrderViewController ()

@end

@implementation iPadEditOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        self.currentMode = orderEditModeEdit;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Order Details"];
    
    switch (self.currentMode) {
        case orderEditModeAdd:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit Order" style:UIBarButtonItemStyleDone target:self action:@selector(addOrder)];
            break;
        case orderEditModeEdit:
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save Order" style:UIBarButtonItemStyleDone target:self action:@selector(addOrder)];
            break;
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addOrder {
    [OrderManager sharedInstance].delegate = self;
    [[OrderManager sharedInstance] editingOrder].notes = notesTextView.text;
    [[OrderManager sharedInstance] addOrder:[[OrderManager sharedInstance] editingOrder]];
}
-(void)setSelectedCustomer:(Customer *)cust {
    selectedCustomer = cust;
    [[OrderManager sharedInstance] editingOrder].customer = cust;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)orderWasAdded:(Order *)o {
    [self closeView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        if (indexPath.section == editOrderSectionCustomer) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomerTableViewCell" owner:self options:nil];
            CustomerTableViewCell *cell = [nib objectAtIndex:0];
            cell.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", selectedCustomer.firstname, selectedCustomer.lastname];
            cell.phoneNumberLabel.text = selectedCustomer.phone;
            cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
            return cell;
        } else if (indexPath.section == editOrderSectionNotes) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            
            notesTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width - 10, textViewCellHeight - 10)];
            notesTextView.font = [UIFont systemFontOfSize:14.0];
            notesTextView.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:notesTextView];
            cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
        }
    }
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == editOrderSectionCustomer) {
        return @"Customer";
    } else if (section == editOrderSectionNotes) {
        return @"Order Notes";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == editOrderSectionCustomer) {
        return 58;
    } else if (indexPath.section == editOrderSectionNotes) {
        return textViewCellHeight;
    }
    return 44;
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
