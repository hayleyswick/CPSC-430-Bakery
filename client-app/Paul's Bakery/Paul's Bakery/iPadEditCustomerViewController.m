//
//  iPadEditCustomerViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadEditCustomerViewController.h"

@interface iPadEditCustomerViewController ()

@end

@implementation iPadEditCustomerViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        currentMode = customerEditModeEdit;
        [self initCells];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (currentMode) {
        case customerEditModeAdd:
            [self.navigationItem setTitle:@"Add New Customer"];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addCustomer)];
            break;
        case customerEditModeEdit:
            [self.navigationItem setTitle:@"Edit Customer"];
            break;
        default:
            break;
    }
}
-(void)initCells {
    
    form = [[Form alloc] init];
    FormSection *name = [[FormSection alloc] init];
    name.title = @"Customer Name";
    [name addItem:[[FormItem alloc] initWithIdentifier:@"customer_firstname" withPlaceholder:@"First Name"]];
    [name addItem:[[FormItem alloc] initWithIdentifier:@"customer_lastname" withPlaceholder:@"Last Name"]];
    [form addSection:name];
    FormSection *phone = [[FormSection alloc] init];
    phone.title = @"Phone Number";
    [phone addItem:[[FormItem alloc] initWithIdentifier:@"customer_phone" withPlaceholder:@"Phone"]];
    [form addSection:phone];
    FormSection *address = [[FormSection alloc] init];
    address.title = @"Address";
    [address addItem:[[FormItem alloc] initWithIdentifier:@"customer_street" withPlaceholder:@"12345 Example Dr."]];
    [address addItem:[[FormItem alloc] initWithIdentifier:@"customer_city" withPlaceholder:@"City"]];
    [address addItem:[[FormItem alloc] initWithIdentifier:@"customer_state" withPlaceholder:@"State"]];
    [address addItem:[[FormItem alloc] initWithIdentifier:@"customer_zip" withPlaceholder:@"ZIP Code"]];
    [form addSection:address];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewMode:(customerEditMode)mode {
    currentMode = mode;
}
- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addCustomer {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return form.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[form.sections objectAtIndex:section] items] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TextFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        FormSection *section = [form.sections objectAtIndex:indexPath.section];
        FormItem *item = [section.items objectAtIndex:indexPath.row];
        
        NSString *placeholder = item.placeholder;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width - 10, cell.frame.size.height - 4)];
        
        [textField addTarget:item action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        textField.placeholder = placeholder;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.enablesReturnKeyAutomatically = YES;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [cell.contentView addSubview:textField];
        cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FormSection *formSection = [form.sections objectAtIndex:section];
    return formSection.title;
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
