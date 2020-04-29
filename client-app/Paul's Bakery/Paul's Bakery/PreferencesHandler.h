//
//  PreferencesHandler.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#define kHasValidSession "hasValidSession"
#define kSessionID "session_id"
#define kCurrentUser "current_user"

@interface PreferencesHandler : NSObject

-(id)init;
+(PreferencesHandler *)sharedInstance;

-(BOOL)hasValidSession;
-(NSString *)currentSessionID;
-(User *)currentUser;
-(void)setHasValidSession:(BOOL)hasSession;
-(void)setCurrentSessionID:(NSString *)sessionID;
-(void)setCurrentUser:(User *)user;

@end
