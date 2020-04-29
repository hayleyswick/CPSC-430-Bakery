//
//  iPadUserSettingsViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadUserSettingsViewController.h"

@interface iPadUserSettingsViewController ()

@end

@implementation iPadUserSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settings.png"] tag:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Paul's Bakery Batter Calculator";
}
-(void)viewDidAppear:(BOOL)animated {
    [UserManager sharedInstance].delegate = self;
    [[UserManager sharedInstance] retrieveUpdatedDataForCurrentUser];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFinishChangingUsername {
    [UserManager sharedInstance].delegate = self;
    [[UserManager sharedInstance] retrieveUpdatedDataForCurrentUser];
}

-(void)userDataWasUpdated {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:userSettingsSectionInfo]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([[LoginManager sharedInstance] loggedInUser].type == userTypeAdmin) {
        return 4;
    } else {
        return 3;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == userSettingsSectionInfo) {
        return 1;
    } else if (section == userSettingsSectionOptions) {
        return 2;
    } else if (section == userSettingsSectionLogOut) {
        return 1;
    } else if (section == userSettingsSectionAdministration) {
        return 3;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == userSettingsSectionInfo) {
        
        static NSString *CellIdentifier = @"UserInfoCell";
        UserTableViewCell *cell = (UserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        User *currentUser = [[LoginManager sharedInstance] loggedInUser];
        cell.userFullName.text = [NSString stringWithFormat:@"%@ %@", currentUser.firstname, currentUser.lastname];
        cell.userType.text = [currentUser typeString];
        cell.username.text = [currentUser username];
        cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        static NSString *CellIdentifier = @"UserInfoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
        
        cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0f];
        
        if (indexPath.section == userSettingsSectionOptions) {
            
            
            switch (indexPath.row) {
                case userSettingsRowChangeUsername:
                    cell.textLabel.text = @"Change Username...";
                    break;
                case userSettingsRowChangePassword:
                    cell.textLabel.text = @"Change Password...";
                    break;
            }
            
        } else if (indexPath.section == userSettingsSectionLogOut) {
                
            cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0f];
            cell.textLabel.text = @"Log Out";
                
        } else if (indexPath.section == userSettingsSectionAdministration) {
                
            cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0f];
            switch (indexPath.row) {
                case userSettingsAdminRowManageInventory:
                    cell.textLabel.text = @"Manage Inventory...";
                    break;
                case userSettingsAdminRowManageUsers:
                    cell.textLabel.text = @"Manage Users...";
                    break;
                case userSettingsAdminRowManageCustomers:
                    cell.textLabel.text = @"Manage Customers...";
                    break;
            }
        }
        return cell;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == userSettingsSectionInfo) {
        return @"User";
    } else if (section == userSettingsSectionAdministration) {
        return @"Administration";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == userSettingsSectionInfo) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil];
        UserTableViewCell *cell = [nib objectAtIndex:0];
        return cell.frame.size.height;
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case userSettingsSectionOptions:
            switch (indexPath.row) {
                case userSettingsRowChangeUsername: {
                    iPadChangeUsernameFormViewController *v = [[iPadChangeUsernameFormViewController alloc] init];
                    v.delegate = self;
                    [self presentViewController:[[SheetNavigationController alloc] initWithRootViewController:v] animated:YES completion:nil];
                    break;
                } case userSettingsRowChangePassword: {
                    iPadChangePasswordFormViewController *v = [[iPadChangePasswordFormViewController alloc] init];
                    [self presentViewController:[[SheetNavigationController alloc] initWithRootViewController:v] animated:YES completion:nil];
                    break;
                }
            }
            break;
        case userSettingsSectionLogOut:
            [[LoginManager sharedInstance] logout];
            break;
        case userSettingsSectionAdministration:
            switch (indexPath.row) {
                case userSettingsAdminRowManageInventory: {
                    iPadManageInventoryViewController *v = [[iPadManageInventoryViewController alloc] initWithNibName:@"iPadManageInventoryViewController" bundle:nil];
                    [self presentViewController:v animated:YES completion:nil];
                    break;
                }
                case userSettingsAdminRowManageUsers: {
                    iPadManageUsersViewController *v = [[iPadManageUsersViewController alloc] initWithNibName:@"iPadManageUsersViewController" bundle:nil];
                    [self presentViewController:[[SheetNavigationController alloc] initWithRootViewController:v] animated:YES completion:nil];
                    break;
                }
                case userSettingsAdminRowManageCustomers: {
                    iPadManageCustomersViewController *v = [[iPadManageCustomersViewController alloc] initWithNibName:@"iPadManageCustomersViewController" bundle:nil];
                    [self presentViewController:[[SheetNavigationController alloc] initWithRootViewController:v] animated:YES completion:nil];
                    break;
                }
            }
            break;
    }
}


@end
