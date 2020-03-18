//
//  SelectionItem.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/18/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "SelectionItem.h"

@implementation SelectionItem

-(id)init {
    self = [super init];
    isSelected = NO;
    return self;
}
-(id)initWithImage:(UIImage *)img forText:(NSString *)text {
    self = [self init];
    self.selectionItemImage = img;
    self.selectionItemText = text;
    return self;
}
-(void)setIsSelected:(BOOL)selected {
    isSelected = selected;
}
-(BOOL)isSelected {
    return isSelected;
}
@end
