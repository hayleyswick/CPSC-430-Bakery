//
//  BakeryCalculatorController.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "BakeryCalculatorController.h"

@implementation BakeryCalculatorController

-(id)init {
    self = [super init];
    return self;
}

+(BakeryCalculatorController *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static BakeryCalculatorController *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(void)loginWithUsername:(NSString *)username withPassword:(NSString *)password {
    NSDictionary *data = @{@"username":username, @"password":password};
    RESTQueryController *c = [[RESTQueryController alloc] init];
    [c sendRequestToEndpoint:@"/api/login" usingRequestType:RequestTypePOST withData:data asID:connectionLogin delegate:self];
}

-(void)loginWithSession:(NSString *)sessionID {
    NSDictionary *data = @{@"session_id":sessionID};
    RESTQueryController *c = [[RESTQueryController alloc] init];
    [c sendRequestToEndpoint:@"/api/login_with_session" usingRequestType:RequestTypePOST withData:data asID:connectionLoginWithSession delegate:self];
}

-(void)connection:(RESTQueryController *)conn didFinishWithData:(NSDictionary *)data {
    
    NSString *responseState = [data objectForKey:@kResponseState];
    
    for (NSString *key in data.allKeys) {
        NSLog(@"%@:%@", key, [data objectForKey:key]);
    }
    
    if ([responseState isEqualToString:@"OK"]) {
        switch (conn.connID) {
            case connectionLogin:
                [[PreferencesHandler sharedInstance] setCurrentSessionID:[data objectForKey:@"session_id"]];
                [self loginWithSession:[data objectForKey:@"session_id"]];
                break;
            case connectionLoginWithSession: {
                userType t = userTypeBaker;
                if ([[data objectForKey:@"user_type"] isEqualToString:@"admin"]) {
                    t = userTypeAdmin;
                }
                [[PreferencesHandler sharedInstance] setHasValidSession:YES];
                loggedInUser = [[User alloc] initWithUsername:[data objectForKey:@"username"] withFirstname:[data objectForKey:@"firstname"] withLastname:[data objectForKey:@"lastname"] ofType:t];
                [[PreferencesHandler sharedInstance] setCurrentUser:loggedInUser];
                [self.loginDelegate didLoginAsUser:loggedInUser];
                break;
            }
        }
    } else {
        [self.errorDelegate handleError:[data objectForKey:@kErrorCode]];
    }
}
-(void)connection:(RESTQueryController *)conn didFailWithError:(NSError *)error {
    [self.errorDelegate handleError:@"conn_error"];
}

-(User *)loggedInUser {
    if (!loggedInUser) {
        if ([[PreferencesHandler sharedInstance] hasValidSession]) {
            loggedInUser = [[PreferencesHandler sharedInstance] currentUser];
        }
    }
    return loggedInUser;
}


@end
