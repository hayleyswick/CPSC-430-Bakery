//
//  Customer.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCustomerID "id"
#define kCustomerFirstname "firstname"
#define kCustomerLastname "lastname"
#define kCustomerPhoneNumber "phone_number"
#define kCustomerStreet "street"
#define kCustomerCity "city"
#define kCustomerState "state"
#define kCustomerZip "zip"


@interface Customer : NSObject

@property NSString *customerID;
@property NSString *firstname;
@property NSString *lastname;
@property NSString *phone;
@property NSString *street;
@property NSString *city;
@property NSString *state;
@property NSString *zip;

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;
-(BOOL)isEqual:(Customer *)o;

@end
