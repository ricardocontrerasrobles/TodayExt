//
//  EasyNetwork.h
//
//  Created by Ricardo Contreras on 10/14/14.
//  Copyright (c) 2014 RCR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EasyNetwork : NSObject <NSURLConnectionDelegate>

- (void)apiCall:(NSString *)sentUrlST httpMethod:(NSString*)httpMethod target:(UIViewController*)sentTarget selector:(SEL)selector bodyString:(NSString*)bodyString;
- (void) cancelApiCall;

@property (nonatomic, strong) NSDictionary *json;
@property (nonatomic, strong) UIView *blockView;
@property (nonatomic, strong) NSString *urlST;
@property (nonatomic, strong) UIViewController *target;
@property BOOL log;
@end
