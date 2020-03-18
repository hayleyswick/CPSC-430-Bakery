//
//  ItemSelectionView.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/16/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "ItemSelectionView.h"

@interface ItemSelectionView ()

@end

@implementation ItemSelectionView

- (void)awakeFromNib
{
    baseColor = self.selectionActiveView.backgroundColor;
    self.selectionActiveView.backgroundColor = [UIColor clearColor];
    [self.selectionActiveView.layer setCornerRadius:20];
}
-(void)setImage:(UIImage *)img {
    [self.selectionImage setImage:img];
}
-(void)setText:(NSString *)text {
    [self.selectionText setText:text];
}

- (void)setSelectionActive {
    self.selectionActiveView.backgroundColor = baseColor;
}
-(void)setSelectionInactive {
    self.selectionActiveView.backgroundColor = [UIColor clearColor];
}
@end
