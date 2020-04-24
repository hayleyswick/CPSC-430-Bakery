//
//  CustomerManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"
#import "BakeryCalculatorController.h"

@protocol CustomerManagerDelegate <NSObject>
@optional
-(void)customerDataDidUpdate:(NSArray *)customers;
-(void)customerWasAdded:(Customer *)cust;
@end

@interface CustomerManager : NSObject <BakeryCalculatorCustomerDelegate>

@property NSMutableArray *customers;

@property (nonatomic, strong) id <CustomerManagerDelegate> delegate;

+(CustomerManager *)sharedInstance;
-(id)init;
-(void)fetchCustomerData;
-(void)addCustomer:(Customer *)cust;

@end
