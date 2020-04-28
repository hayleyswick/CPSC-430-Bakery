//
//  iPadChangeUsernameFormViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadModalFormEditor.h"
#import "UserManager.h"
#import "LoginManager.h"

#define kUsername "username"

@protocol ChangeUsernameViewDelegate <NSObject>
@optional
-(void)didFinishChangingUsername;
@end

@interface iPadChangeUsernameFormViewController : iPadModalFormEditor <UserManagerDelegate>

@property (nonatomic, strong) id <ChangeUsernameViewDelegate> delegate;

@end
