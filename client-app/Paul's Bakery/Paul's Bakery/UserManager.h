//
//  UserManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Manager.h"
#import "LoginManager.h"
#import "User.h"

@protocol UserManagerDelegate <NSObject>
@optional
-(void)passwordWasUpdatedForUser:(User *)user;
-(void)usernameWasUpdatedForUser:(User *)user;
-(void)userDataWasUpdated;
@end

@interface UserManager : Manager {
    RESTQueryController *connectionUpdatePassword;
    RESTQueryController *connectionUpdateUsername;
    RESTQueryController *connectionUpdateUserData;
    User *editingUser;
}

@property (nonatomic, strong) id <UserManagerDelegate> delegate;

-(id)init;
+(UserManager *)sharedInstance;
-(void)updatePasswordForUser:(User *)user fromPassword:(NSString *)oldPW toPassword:(NSString *)newPW;
-(void)updateUsernameForUser:(User *)user toUsername:(NSString *)username;
-(void)retrieveUpdatedDataForUser:(User *)user;

@end
