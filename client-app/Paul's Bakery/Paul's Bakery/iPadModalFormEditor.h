//
//  iPadModalFormEditor.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/26/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"

@interface iPadModalFormEditor : UITableViewController {
    Form *form;
}
-(void)setForm:(Form *)f;
-(void)initForm;
-(void)closeView;

@end
