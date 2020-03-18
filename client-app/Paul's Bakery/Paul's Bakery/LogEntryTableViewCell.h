//
//  LogEntryTableViewCell.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 3/10/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogEntryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@end
