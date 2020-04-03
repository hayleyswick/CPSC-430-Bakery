//
//  RESTQueryConnection.m
//  Paul's Bakery
//
//  Created by Collin Mistr on 4/2/20.
//  Copyright (c) 2020 dosdude1 Apps. All rights reserved.
//

#import "RESTQueryController.h"

@implementation RESTQueryController

-(id)init {
    self = [super init];
    return self;
}

-(void)sendRequestToEndpoint:(NSString *)endp usingRequestType:(RequestType)type withData:(NSDictionary *)query asID:(RESTConnectionID)connID delegate:(id)delegateTarget {
    
    self.delegate = delegateTarget;
    self.connID = connID;
    
    NSString *queryString = @"";
    NSString *requestMethod = @"POST";
    
    for (NSString *key in query.allKeys) {
        if (![queryString isEqualToString:@""]) {
            queryString = [queryString stringByAppendingString:@"&"];
        }
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, [query objectForKey:key]]];
    }
    
    switch (type) {
        case RequestTypeGET:
            requestMethod = @"GET";
            break;
        case RequestTypePOST:
            requestMethod = @"POST";
            break;
        default:
            requestMethod = @"GET";
            break;
    }
    
    NSData *queryData = [queryString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *queryLength = [NSString stringWithFormat:@"%d", [queryData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%s:%s%@", ServerAddress, ServerPort, endp]]];
    [request setHTTPMethod:requestMethod];
    [request setValue:queryLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:queryData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse*)response {
    self.responseData = [[NSMutableData alloc] init];
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    [self.delegate connection:self didFinishWithData:responseData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate connection:self didFailWithError:error];
}

@end
