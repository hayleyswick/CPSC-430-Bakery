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

typedef enum {
    connectionLogin = 0,
    connectionLoginWithSession = 1
} RESTConnectionID;

typedef enum {
    RequestTypeGET = 0,
    RequestTypePOST = 1
} RequestType;

@protocol RESTQueryControllerDelegate;

@interface RESTQueryController : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) id <RESTQueryControllerDelegate> delegate;
@property RESTConnectionID connID;
@property (nonatomic, strong) NSMutableData *responseData;

-(id)init;
-(void)sendRequestToEndpoint:(NSString *)endp usingRequestType:(RequestType)type withData:(NSDictionary *)query asID:(RESTConnectionID)connID delegate:(id)delegateTarget;

@end

@protocol RESTQueryControllerDelegate <NSObject>
@optional
-(void)connection:(RESTQueryController *)conn didFinishWithData:(NSDictionary *)data;
-(void)connection:(RESTQueryController *)conn didFailWithError:(NSError *)error;
@end
