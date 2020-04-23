//
//  Form.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Form.h"

@implementation Form

-(id)init {
    self = [super init];
    self.sections = [[NSMutableArray alloc] init];
    return self;
}

-(void)addSection:(FormSection *)section {
    [self.sections addObject:section];
}

@end
