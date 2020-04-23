//
//  Form.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormSection.h"

@interface Form : NSObject

@property NSMutableArray *sections;

-(id)init;
-(void)addSection:(FormSection *)section;

@end
