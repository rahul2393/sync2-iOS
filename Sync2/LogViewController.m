//
//  LogViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *logs = [[SDKManager sharedManager] logs];
    
    self.logTextView.text = logs;    
    
}

- (IBAction)actionButtonTapped:(id)sender {
    
    [UIPasteboard generalPasteboard].string = self.logTextView.text;
}
@end
