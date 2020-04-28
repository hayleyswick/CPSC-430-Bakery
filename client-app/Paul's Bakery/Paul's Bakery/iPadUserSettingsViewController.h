//
//  iPadUserSettingsViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTableViewCell.h"
#import "LoginManager.h"
#import "UserManager.h"
#import "SheetNavigationController.h"
#import "iPadChangePasswordFormViewController.h"
#import "iPadChangeUsernameFormViewController.h"
#import "iPadManageInventoryViewController.h"
#import "iPadEditUserFormViewController.h"

typedef enum {
    userSettingsSectionInfo = 0,
    userSettingsSectionOptions = 1,
    userSettingsSectionLogOut = 2,
    userSettingsSectionAdministration = 3
} userSettingsSection;

typedef enum {
    userSettingsRowChangeUsername = 0,
    userSettingsRowChangePassword = 1
}userSettingsRow;

typedef enum {
    userSettingsAdminRowManageInventory = 0,
    userSettingsAdminRowManageUsers = 1,
    userSettingsAdminRowManageCustomers = 2
}userSettingsAdminRow;

@interface iPadUserSettingsViewController : UITableViewController <ChangeUsernameViewDelegate, UserManagerDelegate>

@end
