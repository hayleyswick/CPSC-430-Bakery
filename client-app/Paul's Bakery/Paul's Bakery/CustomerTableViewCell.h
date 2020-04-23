//
//  CustomerTableViewCell.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/21/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;


@end
