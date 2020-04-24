//
//  Customer.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Customer.h"

@implementation Customer

-(id)init {
    self = [super init];
    return self;
}
-(id)initWithDict:(NSDictionary *)dict {
    self = [self init];
    self.customerID = [dict objectForKey:@kCustomerID];
    self.firstname = [dict objectForKey:@kCustomerFirstname];
    self.lastname = [dict objectForKey:@kCustomerLastname];
    self.phone = [dict objectForKey:@kCustomerPhoneNumber];
    self.street = [dict objectForKey:@kCustomerStreet];
    self.city = [dict objectForKey:@kCustomerCity];
    self.state = [dict objectForKey:@kCustomerState];
    self.zip = [dict objectForKey:@kCustomerZip];
    return self;
}
-(NSDictionary *)dictRepresentation {
    if (!self.customerID) {
        self.customerID = @"";
    }
    return @{@kCustomerID:self.customerID, @kCustomerFirstname:self.firstname, @kCustomerLastname:self.lastname, @kCustomerPhoneNumber:self.phone, @kCustomerStreet:self.street, @kCustomerCity:self.city, @kCustomerState:self.state, @kCustomerZip:self.zip};
}
-(BOOL)isEqual:(Customer *)o {
    return ([self.customerID isEqualToString:o.customerID]);
}
@end
