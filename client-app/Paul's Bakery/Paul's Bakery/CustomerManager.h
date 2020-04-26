//
//  CustomerManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Manager.h"
#import "Customer.h"

@protocol CustomerManagerDelegate <NSObject>
@optional
-(void)customerDataDidUpdate:(NSArray *)customers;
-(void)customerWasAdded:(Customer *)cust;
@end

@interface CustomerManager : Manager {
    RESTQueryController *connectionAddCustomer;
    RESTQueryController *connectionGetCustomers;
}

@property NSMutableArray *customers;

@property (nonatomic, strong) id <CustomerManagerDelegate> delegate;

+(CustomerManager *)sharedInstance;
-(id)init;
-(Customer *)getCustomerWithID:(NSString *)customerID;
-(void)fetchCustomerData;
-(void)addCustomer:(Customer *)cust;

@end
