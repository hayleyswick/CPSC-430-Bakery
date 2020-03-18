//
//  ThemedButton.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/18/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "ThemedButton.h"

@implementation ThemedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.clipsToBounds = YES;
    [self.layer setCornerRadius:10];
}


- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:209.0/255.0 blue:108.0/255.0 alpha:1.0];
    }
    else{
        self.backgroundColor = [UIColor colorWithRed:254.0/255.0 green:188.0/255.0 blue:29.0/255.0 alpha:1.0];
    }
    
}

@end
