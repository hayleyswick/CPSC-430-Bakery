//
//  FormSection.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/22/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "FormSection.h"

@implementation FormSection

-(id)init {
    self = [super init];
    self.items = [[NSMutableArray alloc] init];
    return self;
}

-(void)addItem:(FormItem *)item {
    [self.items addObject:item];
}

@end
