//
//  iPadCalculationViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/16/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemSelectionView.h"
#import "SelectionItem.h"

@interface iPadCalculationViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSMutableArray *cakeTypeSelections;
    NSMutableArray *batterTypeSelections;
}
@property (strong, nonatomic) IBOutlet UICollectionView *cakeTypeSelectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *batterTypeSelectionView;
@property (strong, nonatomic) IBOutlet UIView *quantityView;

@end
