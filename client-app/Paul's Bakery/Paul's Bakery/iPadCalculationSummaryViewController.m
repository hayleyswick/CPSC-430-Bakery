//
//  iPadCalculationSummaryViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadCalculationSummaryViewController.h"

@interface iPadCalculationSummaryViewController ()

@end

@implementation iPadCalculationSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Items";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [[[[OrderManager sharedInstance] editingOrder] items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CalculationItemCell";
    CalculationViewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CalculationViewItemCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    OrderItem *item = [[[[OrderManager sharedInstance] editingOrder] items] objectAtIndex:indexPath.row];
    
    cell.cakeTypeTextLabel.text = item.cakeTypeText;
    cell.batterTypeTextLabel.text= item.batterTypeText;
    cell.cakeTypeImage.image = item.cakeTypeImage;
    cell.batterTypeImage.image = item.batterTypeImage;
    cell.quantityLabel.text = [NSString stringWithFormat:@"Quantity: %d", item.quantity];
    
    cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CalculationViewItemCell" owner:self options:nil];
    CalculationViewItemCell *cell = [nib objectAtIndex:0];
    return cell.frame.size.height;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[[OrderManager sharedInstance] editingOrder] removeItem:[[[[OrderManager sharedInstance] editingOrder] items] objectAtIndex:indexPath.row]];
        [self.delegate didDeleteItemFromEditingOrder];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [addItemView setEditingOrderItem:[[[[OrderManager sharedInstance] editingOrder] items] objectAtIndex:indexPath.row]];
    [addItemView setSelectionMode:selectionModeEdit];
    [self presentViewController:addItemView animated:YES completion:nil];
}

-(void)useAddItemView:(iPadCalculationAddItemViewController *)v{
    addItemView = v;
}
-(void)didFinishEditingOrder {
    
    [self.tableView reloadData];
}
-(void)didFinishSubmittingOrder {
    [self.tableView reloadData];
}
@end
