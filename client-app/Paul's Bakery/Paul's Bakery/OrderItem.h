//
//  OrderItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kOrderItemID "id"
#define kOrderItemBatterType "batter_type"
#define kOrderItemCakeType "cake_type"
#define kOrderItemQuantity "quantity"

#define CakeTypeQuarterSheet "quarter-sheet"
#define CakeTypeHalfSheet "half-sheet"
#define CakeTypeFullSheet "full-sheet"
#define CakeTypeFullRound "full-round"

#define BatterTypeVanilla "vanilla"
#define BatterTypeChocolate "chocolate"

@interface OrderItem : NSObject

-(id)init;
-(id)initWithDict:(NSDictionary *)dict;
-(NSDictionary *)dictRepresentation;
-(BOOL)isEqual:(OrderItem *)i;

@property NSString *itemID;

@property NSString *batterType;
@property NSString *cakeType;
@property NSString *batterTypeText;
@property NSString *cakeTypeText;
@property int quantity;
@property UIImage *batterTypeImage;
@property UIImage *cakeTypeImage;

@end
