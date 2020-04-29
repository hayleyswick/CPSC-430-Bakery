//
//  iPadManageUsersViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "UserTableViewCell.h"
#import "iPadEditUserFormViewController.h"
#import "iPadAddUserFormViewController.h"

@interface iPadManageUsersViewController : UITableViewController <UserManagerDelegate, EditUserViewDelegate> {
    NSArray *preUpdate;
}
@property (strong, nonatomic) IBOutlet UIView *noDataView;
- (IBAction)addNewUser:(id)sender;

@end
