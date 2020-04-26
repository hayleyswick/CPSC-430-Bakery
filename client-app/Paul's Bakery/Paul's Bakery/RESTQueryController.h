//
//  RESTQueryController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ServerAddress "svc.dosdude1.com"
#define ServerPort "5000"

@protocol RESTQueryControllerDelegate;

@interface RESTQueryController : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) id <RESTQueryControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableData *responseData;

-(id)init;
-(void)sendPOSTRequestToEndpoint:(NSString *)endp withData:(NSDictionary *)query delegate:(id)delegateTarget;
-(void)sendGETRequestToEndpoint:(NSString *)endp withData:(NSDictionary *)query delegate:(id)delegateTarget;

@end

@protocol RESTQueryControllerDelegate <NSObject>
@optional
-(void)connection:(RESTQueryController *)conn didFinishWithData:(NSDictionary *)data;
-(void)connection:(RESTQueryController *)conn didFailWithError:(NSError *)error;
@end
