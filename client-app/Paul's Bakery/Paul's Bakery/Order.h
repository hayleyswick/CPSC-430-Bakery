//
//  Order.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderItem.h"

@interface Order : NSObject {
    NSMutableArray *items;
}

-(id)init;
-(void)addItem:(OrderItem *)item;
-(void)removeItem:(OrderItem *)item;
-(NSArray *)getItems;

@property int orderNumber;


@end
