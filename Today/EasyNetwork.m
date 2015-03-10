//
//  EasyNetwork.m
//
//  Created by Ricardo Contreras on 10/14/14.
//  Copyright (c) 2014 RCR. All rights reserved.
//

#import "EasyNetwork.h"

@implementation EasyNetwork
@synthesize json, blockView, target, urlST;

// Make an API Call that will return in json format
- (void)apiCall:(NSString *)sentUrlST httpMethod:(NSString*)httpMethod target:(UIViewController*)sentTarget selector:(SEL)selector bodyString:(NSString*)bodyString {
    
    // Set variables and observer
    target = sentTarget;
    urlST = sentUrlST;
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:urlST object:nil];
    
    // Generate URL Request
    NSURL *url =  [NSURL URLWithString:[urlST stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:httpMethod];
    if (bodyString) {
        [urlRequest setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // Async request and responses
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(_log) {NSLog(@"apiCall to URL: %@", urlST);}
         if ([data length] > 0 && error == nil) {
             // We have some data... lets use it.
             [self apiData:data response:response urlST:urlST target:target];
         } else if ([data length] == 0 && error == nil) {
             if(_log) {NSLog(@"apiCall: No data");}
         } else if (error != nil && error.code == NSURLErrorTimedOut) {
             if(_log) {NSLog(@"apiCall: Time Out");}
         } else if (error != nil) {
             if(_log) {NSLog(@"apiCall Error: %@", error);}
         }
     }];
}

// There was data in our API Call
- (void)apiData:(NSData *)data response:(NSURLResponse*)response urlST:(NSString*)urlST target:(id)target {
    
    // Handle bad HTTP URL Responses
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    int responseCode = (int)[httpResponse statusCode];
    if (responseCode != 200) {
        if(_log) {NSLog(@"apiCall Response Code: %i", responseCode);}
    } else {
        
        // Response is 200 OK...
        if(_log) {NSLog(@"apiCall Response Code: 200");}
        
        // Convert API data to json
        NSError* error;
        json = [NSJSONSerialization JSONObjectWithData:data
                                               options:kNilOptions
                                                 error:&error];
        // Error at serializing json
        // Return an empty json
        if (error) {
            json = nil;
            [self endApiCall];
            
        } else {
            if (json == nil) {
                // End the api call if json is empty.
                [self endApiCall];
            } else {
                // Return json if everything OK.
                [self endApiCall];
            }
        }
    }
}

// You can cancel an API Call
- (void) cancelApiCall {
    json = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:target name:urlST object:nil];
}

// Our Api Call has ended. Lets post the notification. 
- (void) endApiCall {
    [[NSNotificationCenter defaultCenter] postNotificationName:urlST object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:target name:urlST object:nil];
}

@end
