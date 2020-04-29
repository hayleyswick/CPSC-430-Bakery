//
//  CustomerManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "CustomerManager.h"

@implementation CustomerManager

-(id)init {
    self = [super init];
    self.customers = [[NSMutableArray alloc] init];
    return self;
}

+(CustomerManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static CustomerManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(void)connection:(RESTQueryController *)conn didFinishSuccessfullyWithData:(NSDictionary *)data {
    
    if (conn == connectionAddCustomer) {
        Customer *cust = [[Customer alloc] initWithDict:[data objectForKey:@kResponseDataItem]];
        [self.customers addObject:cust];
        [self.delegate customerWasAdded:cust];
    } else if (conn == connectionGetCustomers) {
        [self.customers removeAllObjects];
        for (NSDictionary *d in [data objectForKey:@kResponseDataItem]) {
            Customer *c = [[Customer alloc] initWithDict:d];
            [self.customers addObject:c];
        }
        [self.delegate customerDataDidUpdate:self.customers];
    } else if (conn == connectionSaveCustomerData) {
        [self.delegate didSaveCustomerData];
    }
}

-(Customer *)getCustomerWithID:(NSString *)customerID {
    for (Customer *c in self.customers) {
        if ([[c customerID] isEqualToString:customerID]) {
            return c;
        }
    }
    [self fetchCustomerData];
    return nil;
}

-(void)fetchCustomerData {
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionGetCustomers = [[RESTQueryController alloc] init];
    [connectionGetCustomers sendGETRequestToEndpoint:@"/api/get_customers" withData:data delegate:self];
}
-(void)addCustomer:(Customer *)cust {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[cust dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    connectionAddCustomer = [[RESTQueryController alloc] init];
    [connectionAddCustomer sendPOSTRequestToEndpoint:@"/api/add_customer" withData:data delegate:self];
}
-(void)saveDataForCustomer:(Customer *)cust {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[cust dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    connectionSaveCustomerData = [[RESTQueryController alloc] init];
    [connectionSaveCustomerData sendPOSTRequestToEndpoint:@"/api/update_customer_data" withData:data delegate:self];
}
-(void)removeCustomer:(Customer *)cust {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    [data setObject:cust.customerID forKey:@kCustomerID];
    connectionRemoveCustomer = [[RESTQueryController alloc] init];
    [connectionRemoveCustomer sendPOSTRequestToEndpoint:@"/api/remove_customer" withData:data delegate:self];
    [self.customers removeObject:cust];
}
@end
