//
//  User.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUsername "username"
#define kType "type"
#define kFirstname "firstname"
#define kLastname "lastname"

typedef enum {
    userTypeBaker = 0,
    userTypeAdmin = 1
} userType;

@interface User : NSObject

-(id)init;
-(id)initWithUsername:(NSString *)username withFirstname:(NSString *)first withLastname:(NSString *)last ofType:(userType)type;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;
-(NSString *)typeString;

@property NSString *username;
@property userType type;
@property NSString *firstname;
@property NSString *lastname;


@end
