//
//  OrderItem.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject

-(id)init;

@property NSString *batterType;
@property NSString *cakeType;
@property NSString *batterTypeText;
@property NSString *cakeTypeText;
@property int quantity;
@property UIImage *batterTypeImage;
@property UIImage *cakeTypeImage;

@end
