//
//  BrowserVC.h
//  Today
//
//  Created by Ricardo Contreras on 3/6/15.
//  Copyright (c) 2015 RCR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowserVC : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *titleST;
@property (nonatomic, strong) NSString *urlST;

@end
