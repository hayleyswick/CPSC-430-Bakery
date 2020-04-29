//
//  PreferencesHandler.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "PreferencesHandler.h"

@implementation PreferencesHandler

-(id)init {
    self = [super init];
    return self;
}
+(PreferencesHandler *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static PreferencesHandler *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(BOOL)hasValidSession {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@kHasValidSession]) {
        return [[[NSUserDefaults standardUserDefaults] objectForKey:@kHasValidSession] boolValue];
    }
    return NO;
}
-(NSString *)currentSessionID {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@kSessionID]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@kSessionID];
    }
    return @"";
}
-(User *)currentUser {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@kCurrentUser]) {
        return [[User alloc] initWithDict:[[NSUserDefaults standardUserDefaults] objectForKey:@kCurrentUser]];
    }
    return nil;
}

-(void)setHasValidSession:(BOOL)hasSession {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:hasSession] forKey:@kHasValidSession];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setCurrentSessionID:(NSString *)sessionID {
    [[NSUserDefaults standardUserDefaults] setObject:sessionID forKey:@kSessionID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)setCurrentUser:(User *)user {
    [[NSUserDefaults standardUserDefaults] setObject:[user dictRepresentation] forKey:@kCurrentUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
