//
//  iPadModalFormEditor.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadModalFormEditor.h"

@interface iPadModalFormEditor ()

@end

@implementation iPadModalFormEditor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:219.0/255.0 alpha:1.0f];
}
-(void)initForm {
    
    form = [[Form alloc] init];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setForm:(Form *)f {
    form = f;
    [self.tableView reloadData];
}
- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didChangeSelectionOfItems:(NSArray *)items forIndexPath:(NSIndexPath *)path {
    FormSection *section = [form.sections objectAtIndex:path.section];
    FormItem *formItem = [section.items objectAtIndex:path.row];
    formItem.selectionItems = [[NSMutableArray alloc] initWithArray:items];
    
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    
    FormSection *section = [form.sections objectAtIndex:indexPath.section];
    FormItem *item = [section.items objectAtIndex:indexPath.row];
    
    if (item.type == formItemTypeText) {
        
        static NSString *CellIdentifier = @"TextFieldCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width - 10, cell.frame.size.height - 4)];
        
        [textField addTarget:item action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        
        textField.userInteractionEnabled = item.editable;
        textField.secureTextEntry = item.secure;
        textField.text = item.value;
        textField.placeholder = item.placeholder;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.enablesReturnKeyAutomatically = YES;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [cell.contentView addSubview:textField];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
        
        return cell;
    } else if (item.type == formItemTypeSelection) {
        static NSString *CellIdentifier = @"SelectionItemCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.text = item.placeholder;
        cell.detailTextLabel.text = [item selectedItem].selectionText;
        cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
        
        return cell;
    }
    return nil;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FormSection *section = [form.sections objectAtIndex:indexPath.section];
    FormItem *item = [section.items objectAtIndex:indexPath.row];
    if (item.type == formItemTypeSelection) {
        ModalFormSelectionEditor *selEditor = [[ModalFormSelectionEditor alloc] init];
        selEditor.delegate = self;
        selEditor.editingIndexPath = indexPath;
        [selEditor setSelectionItems:item.selectionItems];
        [self.navigationController pushViewController:selEditor animated:YES];
    }
}


@end
