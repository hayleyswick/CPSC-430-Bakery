//
//  Manager.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/25/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PreferencesHandler.h"
#import "RESTQueryController.h"

#define kResponseState "status"
#define kResponseDataItem "data"
#define kErrorCode "code"

@interface Manager : NSObject

-(id)init;
-(void)handleError:(NSString *)err_code;

@end
