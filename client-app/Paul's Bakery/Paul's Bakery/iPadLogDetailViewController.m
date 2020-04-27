//
//  iPadLogDetailViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadLogDetailViewController.h"

@interface iPadLogDetailViewController ()

@end

@implementation iPadLogDetailViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)setSelectedOrder:(Order *)o {
    selectedOrder = o;
    preUpdate = [NSArray arrayWithArray:o.items];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Order %d", o.orderNumber]];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:orderDetailSectionCustomer]] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (notesTextView) {
        [notesTextView setText:o.notes];
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [OrderManager sharedInstance].delegate = self;
    [[OrderManager sharedInstance] fetchItemsForOrder:selectedOrder];
}
-(void)didReceiveItemsForOrder:(Order *)o {
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *removeIndexPaths = [[NSMutableArray alloc] init];
    for (int i=0; i < o.items.count; i++) {
        if (![preUpdate containsObject:[o.items objectAtIndex:i]]) {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:orderDetailSectionItems]];
        }
    }
    for (int i=0; i < preUpdate.count; i++) {
        if (![o.items containsObject:[preUpdate objectAtIndex:i]]) {
            [removeIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:orderDetailSectionItems]];
        }
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    preUpdate = [NSArray arrayWithArray:o.items];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == orderDetailSectionItems) {
        return selectedOrder.items.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        if (indexPath.section == orderDetailSectionCustomer) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomerTableViewCell" owner:self options:nil];
            CustomerTableViewCell *cell = [nib objectAtIndex:0];
            cell.customerNameLabel.text = [NSString stringWithFormat:@"%@ %@", selectedOrder.customer.firstname, selectedOrder.customer.lastname];
            cell.phoneNumberLabel.text = selectedOrder.customer.phone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
            return cell;
            
        } else if (indexPath.section == orderDetailSectionItems) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MultiDetailTableViewCell" owner:self options:nil];
            MultiDetailTableViewCell *cell = [nib objectAtIndex:0];

            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
            cell.mainTextLabel.text = [[selectedOrder.items objectAtIndex:indexPath.row] cakeTypeText];
            cell.mainDetailTextLabel.text = [[selectedOrder.items objectAtIndex:indexPath.row] batterTypeText];
            cell.secondaryDetailTextLabel.text = [NSString stringWithFormat:@"Quantity: %d", [[selectedOrder.items objectAtIndex:indexPath.row] quantity]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else if (indexPath.section == orderDetailSectionNotes) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            notesTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width - 10, textViewCellHeight - 10)];
            [notesTextView setText:selectedOrder.notes];
            [notesTextView setEditable:NO];
            notesTextView.font = [UIFont systemFontOfSize:14.0];
            notesTextView.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:notesTextView];
            cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == orderDetailSectionCustomer) {
        return @"Customer";
    } else if (section == orderDetailSectionItems) {
        return @"Items";
    } else if (section == orderDetailSectionNotes) {
        return @"Notes";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == orderDetailSectionCustomer) {
        return 58;
    } else if (indexPath.section == orderDetailSectionNotes) {
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == orderDetailSectionCustomer) {
        editCustomerView = [[iPadEditCustomerViewController alloc] init];
        [editCustomerView setViewMode:customerEditModeView];
        [editCustomerView setEditingCustomer:selectedOrder.customer];
        [self.navigationController pushViewController:editCustomerView animated:YES];
    }
}

@end
