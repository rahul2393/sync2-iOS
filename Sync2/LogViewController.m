//
//  LogViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()
@property (nonatomic, strong) NSString *logs;
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logs = [[SDKManager sharedManager] logs];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.logTextView setText:self.logs];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.logTextView setText:self.logs];
}

- (IBAction)actionButtonTapped:(id)sender {
    
    [UIPasteboard generalPasteboard].string = self.logTextView.text;
}
@end
