//
//  iPadCalculationAddItemViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemSelectionView.h"
#import "Order.h"
#import "SelectionItem.h"

@protocol AddOrderItemDelegate <NSObject>
@optional
-(void)didFinishEditingWithItem:(OrderItem *)item;
@end

@interface iPadCalculationAddItemViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    NSMutableArray *cakeTypeSelections;
    NSMutableArray *batterTypeSelections;
}

@property (nonatomic, strong) id<AddOrderItemDelegate> delegate;

@property (strong, nonatomic) IBOutlet UICollectionView *cakeTypeSelectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *batterTypeSelectionView;
@property (strong, nonatomic) IBOutlet UIView *quantityView;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UIStepper *quantityControl;
- (IBAction)quantityValueChanged:(id)sender;
- (IBAction)closeView:(id)sender;
- (IBAction)addItemAndClose:(id)sender;
- (void)clear;

@end
