//
//  MultiDetailTableViewCell.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *mainDetailTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondaryDetailTextLabel;

@end
