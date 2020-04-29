//
//  iPadEditUserFormViewController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/28/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "iPadModalFormEditor.h"
#import "UserManager.h"

@protocol EditUserViewDelegate <NSObject>
@optional
-(void)didFinishEditingUserAtIndexPath:(NSIndexPath *)path;
@end

@interface iPadEditUserFormViewController : iPadModalFormEditor <UserManagerDelegate> {
    User *editingUser;
    NSIndexPath *editingIndexPath;
}

@property (nonatomic, strong) id <EditUserViewDelegate> delegate;

-(void)beginEditingUser:(User *)u atIndexPath:(NSIndexPath *)editing;

@end
