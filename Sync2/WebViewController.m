//
//  WebViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property(nonatomic, strong) WKWebView *webView;
@end

@implementation WebViewController

- (void)loadView {
    self.webView = [[WKWebView alloc] init];
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleString;
    
    NSURL *url = [[NSURL alloc] initWithString:self.urlString];
    if (url) {
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:req];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    [doneButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = doneButton;
}


- (void)dismiss {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
