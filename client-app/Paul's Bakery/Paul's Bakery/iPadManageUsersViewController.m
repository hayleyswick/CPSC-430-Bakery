//
//  iPadManageUsersViewController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadManageUsersViewController.h"

@interface iPadManageUsersViewController ()

@end

@implementation iPadManageUsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        preUpdate = [NSArray arrayWithArray:[[UserManager sharedInstance] users]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    
    self.navigationItem.title = @"Manage Users";
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
-(void)showAddUserView {
    [self setEditing:NO animated:NO];
    iPadAddUserFormViewController *v = [[iPadAddUserFormViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}
-(void)viewDidAppear:(BOOL)animated {
    [UserManager sharedInstance].delegate = self;
    [[UserManager sharedInstance] fetchAllUsers];
}
-(void)didReceiveAllUsers:(NSArray *)users {
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *removeIndexPaths = [[NSMutableArray alloc] init];
    for (int i=0; i < users.count; i++) {
        if (![preUpdate containsObject:[users objectAtIndex:i]]) {
            [insertIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    for (int i=0; i < preUpdate.count; i++) {
        if (![users containsObject:[preUpdate objectAtIndex:i]]) {
            [removeIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    preUpdate = [NSArray arrayWithArray:users];
}

-(void)didFinishEditingUserAtIndexPath:(NSIndexPath *)path {
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [UserManager sharedInstance].users.count;
    if (count < 1) {
        [self.view addSubview:self.noDataView];
    } else {
        [self.noDataView removeFromSuperview];
    }
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserInfoCell";
    UserTableViewCell *cell = (UserTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    User *currentUser = [[[UserManager sharedInstance] users] objectAtIndex:indexPath.row];
    cell.userFullName.text = [NSString stringWithFormat:@"%@ %@", currentUser.firstname, currentUser.lastname];
    cell.userType.text = [currentUser typeString];
    cell.username.text = [currentUser username];
    cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:235.0/255.0 blue:188.0/255.0 alpha:1.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil];
    UserTableViewCell *cell = [nib objectAtIndex:0];
    return cell.frame.size.height;
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        User *u = [[[UserManager sharedInstance] users] objectAtIndex:indexPath.row];
        [[UserManager sharedInstance] removeUser:u];
        preUpdate = [NSArray arrayWithArray:[[UserManager sharedInstance] users]];
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
    iPadEditUserFormViewController *v = [[iPadEditUserFormViewController alloc] init];
    v.delegate = self;
    [v beginEditingUser:[[[UserManager sharedInstance] users] objectAtIndex:indexPath.row] atIndexPath:indexPath];
    [self.navigationController pushViewController:v animated:YES];
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    if (editing) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(showAddUserView)] animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)] animated:YES];
    }
}

- (IBAction)addNewUser:(id)sender {
    [self showAddUserView];
}
@end
