//
//  InfoViewController.m
//  ynnuS
//
//  Created by Jason Garrett on 1/23/14.
//  Copyright (c) 2014 Ulnar Nerve LLC. All rights reserved.
//

#import "RemoteHTMLViewController.h"

@interface RemoteHTMLViewController () <UIWebViewDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RemoteHTMLViewController

@synthesize url;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_VIEW_BACKGROUND;
    
    self.webView.delegate = self;

   
    
//    NSString *aboutStr = @"ynnuS is an iOS app÷ that records sounds and plays them backwards.\n\nWhy? \n\nBecause, it's always sunny in philadelphia...\n\n♪♫♪ raadaath moonf noorbar reear ♩♫♩ \n\nbecomes magically: \n\n♪♫♪ Eagles are born from thuunder! ♩♫♩ \n\n(Try credits when the ball hits the wall)";
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.backBarButtonItem.title = @"";
    
    if (self.url) {
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.url]];
    }
    
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [APP_DELEGATE showHud:@"One moment..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
   [APP_DELEGATE hideHud];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [APP_DELEGATE hideHud];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opps.." message:@"Something went wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
