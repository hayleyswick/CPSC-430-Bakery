//
//  iPadAddUserFormViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadModalFormEditor.h"
#import "UserManager.h"

#define kPassword "password"
#define kPasswordConfirmation "password_confirm"

@interface iPadAddUserFormViewController : iPadModalFormEditor <UserManagerDelegate>

@end
