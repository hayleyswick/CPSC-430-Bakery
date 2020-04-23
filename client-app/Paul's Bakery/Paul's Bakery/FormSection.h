//
//  FormSection.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormItem.h"

@interface FormSection : NSObject

@property NSString *title;
@property NSMutableArray *items;

-(id)init;
-(void)addItem:(FormItem *)item;

@end
