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
-(FormItem *)getItemWithIdentifier:(NSString *)identifier {
    for (FormSection *s in self.sections) {
        for (FormItem *i in s.items) {
            if ([i.identifier isEqualToString:identifier]) {
                return i;
            }
        }
    }
    return nil;
}
-(NSArray *)getAllItems {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (FormSection *s in self.sections) {
        for (FormItem *i in s.items) {
            [items addObject:i];
        }
    }
    return [NSArray arrayWithArray:items];
}
@end
