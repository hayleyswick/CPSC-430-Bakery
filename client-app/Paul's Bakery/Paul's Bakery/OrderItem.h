//
//  OrderItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kOrderItemBatterType "batter_type"
#define kOrderItemCakeType "cake_type"
#define kOrderItemQuantity "quantity"

@interface OrderItem : NSObject

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;

@property NSString *batterType;
@property NSString *cakeType;
@property NSString *batterTypeText;
@property NSString *cakeTypeText;
@property int quantity;
@property UIImage *batterTypeImage;
@property UIImage *cakeTypeImage;

@end
