//
//  CalculationViewItemCell.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/3/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculationViewItemCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cakeTypeImage;
@property (strong, nonatomic) IBOutlet UIImageView *batterTypeImage;
@property (strong, nonatomic) IBOutlet UILabel *cakeTypeTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *batterTypeTextLabel;

@end
