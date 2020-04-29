//
//  User.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUsername "username"
#define kType "user_type"
#define kFirstname "firstname"
#define kLastname "lastname"
#define kUserID "user_id"

#define AdminString "Admin"
#define BakerString "Baker"

typedef enum {
    userTypeBaker = 0,
    userTypeAdmin = 1
} userType;

@interface User : NSObject

-(id)init;
-(id)initWithUsername:(NSString *)username withFirstname:(NSString *)first withLastname:(NSString *)last ofType:(userType)type;
-(id)initWithDict:(NSDictionary *)dict;
-(void)updateWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;
-(NSString *)typeString;
-(BOOL)isEqual:(User *)u;

@property NSString *username;
@property userType type;
@property NSString *firstname;
@property NSString *lastname;
@property NSString *userID;


@end
