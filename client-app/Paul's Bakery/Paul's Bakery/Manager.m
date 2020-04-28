//
//  Manager.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/25/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "Manager.h"

@implementation Manager

-(id)init {
    self = [super init];
    return self;
}

-(void)connection:(RESTQueryController *)conn didFinishWithData:(NSDictionary *)data {
    
    NSString *responseState = [data objectForKey:@kResponseState];
    
    for (NSString *key in data.allKeys) {
        NSLog(@"%@:%@", key, [data objectForKey:key]);
    }
    
    if ([responseState isEqualToString:@"OK"]) {
        [self connection:conn didFinishSuccessfullyWithData:data];
    } else {
        [self handleError:[data objectForKey:@kErrorCode]];
    }
}

-(void)connection:(RESTQueryController *)conn didFailWithError:(NSError *)error {
    [self handleError:@"conn_error"];
}

-(void)handleError:(NSString *)err_code {
    NSString *title = @"Unknown Error";
    NSString *info = @"An unknown error occurred.";
    if ([err_code isEqualToString:@"incorrect_login"]) {
        title = @"Login Invalid";
        info = @"The username or password you have entered is invalid.";
    } else if ([err_code isEqualToString:@"conn_error"]) {
        title = @"Network Error";
        info = @"The server could not be reached. Please check your Internet connection and try again.";
    } else if ([err_code isEqualToString:@"invalid_session"]) {
        title = @"Invalid Session";
        info = @"Your current session has expired. Please log out.";
    } else if ([err_code isEqualToString:@"customer_exists"]) {
        title = @"Customer Exists";
        info = @"The specified customer has already been added.";
    } else if ([err_code isEqualToString:@"incorrect_old_password"]) {
        title = @"Incorrect Password";
        info = @"The old passwordd you have entered is incorrect.";
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:info delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

-(void)connection:(RESTQueryController *)conn didFinishSuccessfullyWithData:(NSDictionary *)data {
    
}

@end
