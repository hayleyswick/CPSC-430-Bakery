//
//  UserManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/27/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

-(id)init {
    self = [super init];
    self.users = [[NSMutableArray alloc] init];
    return self;
}
+(UserManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static UserManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(void)connection:(RESTQueryController *)conn didFinishSuccessfullyWithData:(NSDictionary *)data {
    if (conn == connectionUpdatePassword) {
        [self.delegate passwordWasUpdatedForUser:editingUser];
    } else if (conn == connectionUpdateUsername) {
        [self.delegate usernameWasUpdatedForUser:editingUser];
    } else if (conn == connectionUpdateUserData) {
        NSDictionary *user = [data objectForKey:@kResponseDataItem];
        userType t = userTypeBaker;
        if ([[user objectForKey:@kType] isEqualToString:@"Admin"]) {
            t = userTypeAdmin;
        }
        [[PreferencesHandler sharedInstance] setHasValidSession:YES];
        User *loggedInUser = [[LoginManager sharedInstance] loggedInUser];
        loggedInUser.username = [user objectForKey:@kUsername];
        loggedInUser.firstname = [user objectForKey:@kFirstname];
        loggedInUser.lastname = [user objectForKey:@kLastname];
        loggedInUser.type = t;
        [[PreferencesHandler sharedInstance] setCurrentUser:loggedInUser];
        [self.delegate userDataWasUpdated];
    } else if (conn == connectionGetUsers) {
        [self.users removeAllObjects];
        for (NSDictionary *d in [data objectForKey:@kResponseDataItem]) {
            [self.users addObject:[[User alloc] initWithDict:d]];
        }
        [self.delegate didReceiveAllUsers:self.users];
    } else if (conn == connectionSaveUserData) {
        [self.delegate didSaveUserData];
    } else if (conn == connectionAddUser) {
        [self.users addObject:editingUser];
        [self.delegate newUserWasAdded];
    }
}
-(void)updatePasswordForCurrentUserFromPassword:(NSString *)oldPW toPassword:(NSString *)newPW {
    editingUser = [[LoginManager sharedInstance] loggedInUser];
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID], @"old_password":oldPW, @"new_password":newPW};
    connectionUpdatePassword = [[RESTQueryController alloc] init];
    [connectionUpdatePassword sendPOSTRequestToEndpoint:@"/api/change_user_password" withData:data delegate:self];
}
-(void)setCurrentUserUsername:(NSString *)username {
    editingUser = [[LoginManager sharedInstance] loggedInUser];
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID], @"username":username};
    connectionUpdateUsername = [[RESTQueryController alloc] init];
    [connectionUpdateUsername sendPOSTRequestToEndpoint:@"/api/change_user_username" withData:data delegate:self];
}
-(void)retrieveUpdatedDataForCurrentUser {
    editingUser = [[LoginManager sharedInstance] loggedInUser];
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionUpdateUserData = [[RESTQueryController alloc] init];
    [connectionUpdateUserData sendPOSTRequestToEndpoint:@"/api/login_with_session" withData:data delegate:self];
}
-(void)fetchAllUsers {
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionGetUsers = [[RESTQueryController alloc] init];
    [connectionGetUsers sendGETRequestToEndpoint:@"/api/get_users" withData:data delegate:self];
}
-(void)saveDataForUser:(User *)u {
    editingUser = u;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[u dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    [data setObject:u.userID forKey:@kUserID];
    connectionSaveUserData = [[RESTQueryController alloc] init];
    [connectionSaveUserData sendPOSTRequestToEndpoint:@"/api/update_user_data" withData:data delegate:self];
}
-(void)removeUser:(User *)u {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    [data setObject:u.userID forKey:@kUserID];
    connectionRemoveUser = [[RESTQueryController alloc] init];
    [connectionRemoveUser sendPOSTRequestToEndpoint:@"/api/remove_user" withData:data delegate:self];
    [self.users removeObject:u];
}
-(void)addUser:(User *)u withPassword:(NSString *)password {
    editingUser = u;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[u dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    [data setObject:password forKey:@"password"];
    connectionAddUser = [[RESTQueryController alloc] init];
    [connectionAddUser sendPOSTRequestToEndpoint:@"/api/create_user" withData:data delegate:self];
}
@end
