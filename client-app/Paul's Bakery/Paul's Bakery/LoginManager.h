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
@end

@interface LoginManager : Manager <RESTQueryControllerDelegate> {
    RESTQueryController *connectionLoginWithUsername;
    RESTQueryController *connectionLoginWithSession;
    User *loggedInUser;
}

@property (nonatomic, strong) id <LoginManagerDelegate> delegate;

-(id)init;
+(LoginManager *)sharedInstance;
-(void)loginWithUsername:(NSString *)username withPassword:(NSString *)password;
-(void)loginWithSession:(NSString *)sessionID;
-(User *)loggedInUser;

@end
