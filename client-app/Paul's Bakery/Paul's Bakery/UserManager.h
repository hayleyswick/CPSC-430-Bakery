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
-(void)didReceiveAllUsers:(NSArray *)users;
-(void)didSaveUserData;
-(void)newUserWasAdded;
@end

@interface UserManager : Manager {
    RESTQueryController *connectionUpdatePassword;
    RESTQueryController *connectionUpdateUsername;
    RESTQueryController *connectionUpdateUserData;
    RESTQueryController *connectionGetUsers;
    RESTQueryController *connectionSaveUserData;
    RESTQueryController *connectionRemoveUser;
    RESTQueryController *connectionAddUser;
    User *editingUser;
}

@property (nonatomic, strong) id <UserManagerDelegate> delegate;

@property NSMutableArray *users;

-(id)init;
+(UserManager *)sharedInstance;
-(void)updatePasswordForCurrentUserFromPassword:(NSString *)oldPW toPassword:(NSString *)newPW;
-(void)setCurrentUserUsername:(NSString *)username;
-(void)retrieveUpdatedDataForCurrentUser;
-(void)fetchAllUsers;
-(void)saveDataForUser:(User *)u;
-(void)removeUser:(User *)u;
-(void)addUser:(User *)u withPassword:(NSString *)password;

@end
