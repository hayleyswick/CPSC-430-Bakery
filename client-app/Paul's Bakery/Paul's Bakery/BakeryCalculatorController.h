//
//  BakeryCalculatorController.h
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RESTQueryController.h"
#import "User.h"
#import "PreferencesHandler.h"
#import "Customer.h"

#define kResponseState "status"
#define kErrorCode "code"

typedef enum {
    errLoginInvalid = 1,
    errSessionInvalid = 2
}err;

@protocol BakeryCalculatorLoginDelegate <NSObject>
@optional
-(void)didLoginAsUser:(User *)user;
@end

@protocol BakeryCalculatorErrorDelegate <NSObject>
@optional
-(void)handleError:(NSString *)err_code;
@end

@protocol BakeryCalculatorCustomerDelegate <NSObject>
@optional
-(void)didReceiveCustomerData:(NSArray *)customerData;
-(void)didAddCustomerWithData:(NSDictionary *)data;
@end

@interface BakeryCalculatorController : NSObject {
    User *loggedInUser;
}

@property (nonatomic, strong) id <BakeryCalculatorLoginDelegate> loginDelegate;
@property (nonatomic, strong) id <BakeryCalculatorErrorDelegate> errorDelegate;
@property (nonatomic, strong) id <BakeryCalculatorCustomerDelegate> customerDelegate;

-(id)init;
+(BakeryCalculatorController *)sharedInstance;
-(void)loginWithUsername:(NSString *)username withPassword:(NSString *)password;
-(void)loginWithSession:(NSString *)sessionID;
-(User *)loggedInUser;
-(void)retrieveCustomers;
-(void)addCustomer:(Customer *)c;

@end
