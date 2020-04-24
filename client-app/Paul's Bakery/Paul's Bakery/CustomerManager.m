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
    [BakeryCalculatorController sharedInstance].customerDelegate = self;
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
-(void)didReceiveCustomerData:(NSArray *)customerData {
    [self.customers removeAllObjects];
    for (NSDictionary *d in customerData) {
        Customer *c = [[Customer alloc] initWithDict:d];
        [self.customers addObject:c];
    }
    [self.delegate customerDataDidUpdate:self.customers];
}
-(void)didAddCustomerWithData:(NSDictionary *)data {
    Customer *cust = [[Customer alloc] initWithDict:data];
    [self.customers addObject:cust];
    [self.delegate customerWasAdded:cust];
}
-(void)fetchCustomerData {
    [[BakeryCalculatorController sharedInstance] retrieveCustomers];
}
-(void)addCustomer:(Customer *)cust {
    [[BakeryCalculatorController sharedInstance] addCustomer:cust];
}
@end
