//
//  TodayViewController.m
//  TodayExt
//
//  Created by Ricardo Contreras on 3/6/15.
//  Copyright (c) 2015 RCR. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "UX.h"

@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic, strong) UX *ux;
@end

@implementation TodayViewController
@synthesize ux = _ux;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ux = [[UX alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDefaultsDidChange:) name:NSUserDefaultsDidChangeNotification object:nil];
    
    self.preferredContentSize = CGSizeMake(0, 200);
    
    [self makeUI];

}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self makeUI];
}

- (void) makeUI {
    
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    NSUserDefaults *usrDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.rcr.today"];
    NSData *encodedObject = [usrDefaults objectForKey:@"items"];
    if (encodedObject) {
        NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        NSLog(@"items: %@", items);
        
        int y = 0;
        if (items.count > 5) {
            for (int i = 0; i < 6; i++) {
                NSDictionary *item = items[i];
                UILabel *lb = [_ux makeLabelWithText:item[@"title"] font:_ux.fontLight textColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft x:0 y:y width:self.view.frame.size.width-20 height:20];
                [self.view addSubview:lb];
                y = y + 40;
            }
        }
    }
    [self.view addSubview:[_ux makeButtonWithText:@"" target:self selector:@selector(goToApp) font:nil textColor:nil image:nil background:nil backgroundColor:[UIColor clearColor] x:0 y:0 width:self.view.frame.size.width-20 height:self.view.frame.size.height tag:1]];
}

-(void) goToApp {
    NSLog(@"goToApp");
    NSURL *pjURL = [NSURL URLWithString:@"rcrToday://home"];
    [self.extensionContext openURL:pjURL completionHandler:nil];
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    completionHandler(NCUpdateResultNewData);
}

@end
