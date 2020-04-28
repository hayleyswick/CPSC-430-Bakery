//
//  FormItemSelection.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "FormItemSelection.h"

@implementation FormItemSelection

-(id)init {
    self = [super init];
    return self;
}

-(id)initWithSelectionText:(NSString *)text selected:(BOOL)selected {
    self = [self init];
    self.selectionText = text;
    self.selected = selected;
    return self;
}

-(BOOL)isEqual:(FormItemSelection *)item {
    return ([self.selectionText isEqualToString:item.selectionText]);
}

@end
