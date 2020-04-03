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

typedef enum {
    userTypeBaker = 0,
    userTypeAdmin = 1
} userType;

@interface User : NSObject

-(id)init;
-(id)initWithUsername:(NSString *)username ofType:(userType)type;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;

@property NSString *username;
@property userType type;


@end
