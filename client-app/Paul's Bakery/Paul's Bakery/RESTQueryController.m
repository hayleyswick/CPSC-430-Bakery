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

-(void)sendPOSTRequestToEndpoint:(NSString *)endp withData:(NSDictionary *)query asID:(RESTConnectionID)connID delegate:(id)delegateTarget {
    
    self.delegate = delegateTarget;
    self.connID = connID;
    
    NSString *queryString = [self getQueryStringForDict:query];
    NSData *queryData = [queryString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *queryLength = [NSString stringWithFormat:@"%d", [queryData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%s:%s%@", ServerAddress, ServerPort, endp]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:queryLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:queryData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}
-(void)sendGETRequestToEndpoint:(NSString *)endp withData:(NSDictionary *)query asID:(RESTConnectionID)connID delegate:(id)delegateTarget {
    self.delegate = delegateTarget;
    self.connID = connID;
    
    NSString *queryString = [self getQueryStringForDict:query];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%s:%s%@?%@", ServerAddress, ServerPort, endp, queryString]]];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}

-(NSString *)getQueryStringForDict:(NSDictionary *)dict {
    NSString *queryString = @"";
    
    for (NSString *key in dict.allKeys) {
        if (![queryString isEqualToString:@""]) {
            queryString = [queryString stringByAppendingString:@"&"];
        }
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]]];
    }
    return queryString;
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
