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
    self.username = [dict objectForKey:@kUsername];
    self.type = [[dict objectForKey:@kType] intValue];
    self.firstname = [dict objectForKey:@kFirstname];
    self.lastname = [dict objectForKey:@kLastname];
    return self;
}
-(NSDictionary *)dictRepresentation {
    return @{@kUsername:self.username, @kType:[NSNumber numberWithInt:self.type], @kFirstname:self.firstname, @kLastname:self.lastname};
}
@end
