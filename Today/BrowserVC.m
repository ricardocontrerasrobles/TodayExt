//
//  BrowserVC.m
//  Today
//
//  Created by Ricardo Contreras on 3/6/15.
//  Copyright (c) 2015 RCR. All rights reserved.
//

#import "BrowserVC.h"
#import "UX.h"

@interface BrowserVC ()
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UX *ux;
@end

@implementation BrowserVC
@synthesize activityView = _activityView;
@synthesize titleST ;
@synthesize urlST;
@synthesize ux = _ux;

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
    [self.view sendSubviewToBack:self.activityView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ux = [[UX alloc]init];
    [_ux initNav:self];
    
    self.title = titleST;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44-20)];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlST]]];
    [self.view addSubview:webView];
    
    self.activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
