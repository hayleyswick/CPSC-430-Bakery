//
//  OrderManager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
#import "BakeryCalculatorController.h"

@interface OrderManager : NSObject <BakeryCalculatorOrderDelegate>

@property (nonatomic, strong) Order *editingOrder;
@property NSMutableArray *orders;

-(id)init;
+(OrderManager *)sharedInstance;
-(void)addOrder:(Order *)o;
-(void)removeOrder:(Order *)o;


@end
