//
//  LoginManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/25/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Manager.h"
#import "User.h"

@protocol LoginManagerDelegate <NSObject>
@optional
-(void)didLoginAsUser:(User *)user;
-(void)didLogoutSuccessfully;
@end

@interface LoginManager : Manager <RESTQueryControllerDelegate> {
    RESTQueryController *connectionLoginWithUsername;
    RESTQueryController *connectionLoginWithSession;
    RESTQueryController *connectionLogout;
    User *loggedInUser;
}

@property (nonatomic, strong) id <LoginManagerDelegate> delegate;

-(id)init;
+(LoginManager *)sharedInstance;
-(void)loginWithUsername:(NSString *)username withPassword:(NSString *)password;
-(void)loginWithSession:(NSString *)sessionID;
-(User *)loggedInUser;
-(void)logout;
-(void)forceLogout;

@end
