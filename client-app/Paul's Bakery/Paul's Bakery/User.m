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
-(id)initWithUsername:(NSString *)username ofType:(userType)type{
    self = [self init];
    self.username = username;
    self.type = type;
    return self;
}
-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    self.username = [dict objectForKey:@kUsername];
    self.type = [[dict objectForKey:@kType] intValue];
    return self;
}
-(NSDictionary *)dictRepresentation {
    return @{@kUsername:self.username, @kType:[NSNumber numberWithInt:self.type]};
}
@end
