//
//  ItemSelectionView.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/16/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSelectionView : UICollectionViewCell {
    UIColor *baseColor;
}

@property (strong, nonatomic) IBOutlet UILabel *selectionText;
@property (strong, nonatomic) IBOutlet UIImageView *selectionImage;
@property (strong, nonatomic) IBOutlet UIView *selectionActiveView;

-(void)setImage:(UIImage *)img;
-(void)setText:(NSString *)text;
-(void)setSelectionActive;
-(void)setSelectionInactive;

@end
