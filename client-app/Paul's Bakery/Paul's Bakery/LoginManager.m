//
//  LoginManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/25/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

-(id)init {
    self = [super init];
    return self;
}
+(LoginManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LoginManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(void)loginWithUsername:(NSString *)username withPassword:(NSString *)password {
    NSDictionary *data = @{@"username":username, @"password":password};
    connectionLoginWithUsername = [[RESTQueryController alloc] init];
    [connectionLoginWithUsername sendPOSTRequestToEndpoint:@"/api/login" withData:data delegate:self];
}

-(void)loginWithSession:(NSString *)sessionID {
    NSDictionary *data = @{@"session_id":sessionID};
    connectionLoginWithSession = [[RESTQueryController alloc] init];
    [connectionLoginWithSession sendPOSTRequestToEndpoint:@"/api/login_with_session" withData:data delegate:self];
}

-(void)connection:(RESTQueryController *)conn didFinishSuccessfullyWithData:(NSDictionary *)data {
    if (conn == connectionLoginWithUsername) {
        [[PreferencesHandler sharedInstance] setCurrentSessionID:[data objectForKey:@"session_id"]];
        [self loginWithSession:[data objectForKey:@"session_id"]];
    } else if (conn == connectionLoginWithSession) {
        NSDictionary *user = [data objectForKey:@kResponseDataItem];
        [[PreferencesHandler sharedInstance] setHasValidSession:YES];
        loggedInUser = [[User alloc] initWithDict:user];
        [[PreferencesHandler sharedInstance] setCurrentUser:loggedInUser];
        [self.delegate didLoginAsUser:loggedInUser];
    } else if (conn == connectionLogout) {
        [[PreferencesHandler sharedInstance] setHasValidSession:NO];
        [[PreferencesHandler sharedInstance] setCurrentSessionID:@""];
        [self.delegate didLogoutSuccessfully];
    } 
}
-(User *)loggedInUser {
    if (!loggedInUser) {
        if ([[PreferencesHandler sharedInstance] hasValidSession]) {
            loggedInUser = [[PreferencesHandler sharedInstance] currentUser];
        }
    }
    return loggedInUser;
}
-(void)logout {
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionLogout = [[RESTQueryController alloc] init];
    [connectionLogout sendPOSTRequestToEndpoint:@"/api/logout" withData:data delegate:self];
}
-(void)forceLogout {
    [[PreferencesHandler sharedInstance] setHasValidSession:NO];
    [[PreferencesHandler sharedInstance] setCurrentSessionID:@""];
    [self.delegate didLogoutSuccessfully];
}
@end
