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
        if ([[user objectForKey:@"user_type"] isEqualToString:@"admin"]) {
            t = userTypeAdmin;
        }
        [[PreferencesHandler sharedInstance] setHasValidSession:YES];
        User *loggedInUser = [[LoginManager sharedInstance] loggedInUser];
        loggedInUser.username = [user objectForKey:@"username"];
        loggedInUser.firstname = [user objectForKey:@"firstname"];
        loggedInUser.lastname = [user objectForKey:@"lastname"];
        loggedInUser.type = t;
        [[PreferencesHandler sharedInstance] setCurrentUser:loggedInUser];
        [self.delegate userDataWasUpdated];
    }
}
-(void)updatePasswordForUser:(User *)user fromPassword:(NSString *)oldPW toPassword:(NSString *)newPW {
    editingUser = user;
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID], @"old_password":oldPW, @"new_password":newPW};
    connectionUpdatePassword = [[RESTQueryController alloc] init];
    [connectionUpdatePassword sendPOSTRequestToEndpoint:@"/api/change_user_password" withData:data delegate:self];
}
-(void)updateUsernameForUser:(User *)user toUsername:(NSString *)username {
    editingUser = user;
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID], @"username":username};
    connectionUpdateUsername = [[RESTQueryController alloc] init];
    [connectionUpdateUsername sendPOSTRequestToEndpoint:@"/api/change_user_username" withData:data delegate:self];
}
-(void)retrieveUpdatedDataForUser:(User *)user {
    editingUser = user;
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionUpdateUserData = [[RESTQueryController alloc] init];
    [connectionUpdateUserData sendPOSTRequestToEndpoint:@"/api/login_with_session" withData:data delegate:self];
}
@end
