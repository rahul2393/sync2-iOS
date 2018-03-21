//
//  TOSViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 20/03/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "TOSViewController.h"
#import "SettingsManager.h"

@interface TOSViewController ()

@end

@implementation TOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[SettingsManager sharedManager] hasOnboarded]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)declineService:(id)sender {
}

- (IBAction)acceptService:(id)sender {
    [self performSegueWithIdentifier:@"showPermissionRequests" sender:self];
}

@end
