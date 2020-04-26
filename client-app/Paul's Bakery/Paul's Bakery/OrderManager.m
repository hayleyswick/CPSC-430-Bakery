//
//  OrderManager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "OrderManager.h"

@implementation OrderManager

-(id)init {
    self = [super init];
    self.orders = [[NSMutableArray alloc] init];
    self.editingOrder = [[Order alloc] init];
    return self;
}
+(OrderManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static OrderManager *sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}


-(void)connection:(RESTQueryController *)conn didFinishSuccessfullyWithData:(NSDictionary *)data {
    
    if (conn == connectionAddOrder) {
        Order *o = [[Order alloc] initWithDict:[data objectForKey:@kResponseDataItem]];
        [self.delegate orderWasAdded:o];
    } else if (conn == connectionGetOrders){
        [self.orders removeAllObjects];
        for (NSDictionary *d in [data objectForKey:@kResponseDataItem]) {
            [self.orders addObject:[[Order alloc] initWithDict:d]];
        }
        [self.delegate orderDataDidUpdate:self.orders];
    }
}

-(void)fetchOrders {
    //Needs customer data first
    [CustomerManager sharedInstance].delegate = self;
    [[CustomerManager sharedInstance] fetchCustomerData];
}
-(void)addOrder:(Order *)o {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithDictionary:[o dictRepresentation]];
    [data setObject:[[PreferencesHandler sharedInstance] currentSessionID] forKey:@"session_id"];
    connectionAddOrder = [[RESTQueryController alloc] init];
    [connectionAddOrder sendPOSTRequestToEndpoint:@"/api/add_order" withData:data delegate:self];
}
-(void)removeOrder:(Order *)o {
    
}
-(void)customerDataDidUpdate:(NSArray *)customers {
    NSDictionary *data = @{@"session_id":[[PreferencesHandler sharedInstance] currentSessionID]};
    connectionGetOrders = [[RESTQueryController alloc] init];
    [connectionGetOrders sendGETRequestToEndpoint:@"/api/get_orders" withData:data delegate:self];
}
@end
