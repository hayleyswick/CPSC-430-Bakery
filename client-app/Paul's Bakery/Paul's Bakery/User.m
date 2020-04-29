//
//  User.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "User.h"

@implementation User

-(id)init {
    self = [super init];
    self.userID = @"";
    return self;
}
-(id)initWithUsername:(NSString *)username withFirstname:(NSString *)first withLastname:(NSString *)last ofType:(userType)type{
    self = [self init];
    self.username = username;
    self.type = type;
    self.firstname = first;
    self.lastname = last;
    return self;
}
-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    [self updateWithDict:dict];
    return self;
}
-(void)updateWithDict:(NSDictionary *)dict {
    self.username = [dict objectForKey:@kUsername];
    NSString *typeString = [dict objectForKey:@kType];
    if ([typeString isEqualToString:@AdminString]) {
        self.type = userTypeAdmin;
    } else {
        self.type = userTypeBaker;
    }
    self.firstname = [dict objectForKey:@kFirstname];
    self.lastname = [dict objectForKey:@kLastname];
    if ([dict objectForKey:@kUserID]) {
        self.userID = [dict objectForKey:@kUserID];
    }
}
-(NSDictionary *)dictRepresentation {
    return @{@kUsername:self.username, @kType:[self typeString], @kFirstname:self.firstname, @kLastname:self.lastname};
}
-(NSString *)typeString {
    switch (self.type) {
        case userTypeAdmin:
            return @AdminString;
            break;
        case userTypeBaker:
            return @BakerString;
            break;
    }
    return @BakerString;
}
-(BOOL)isEqual:(User *)u {
    return ([self.userID isEqualToString:u.userID]);
}
@end
