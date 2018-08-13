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

- (IBAction)declineService:(id)sender {
}

- (IBAction)acceptService:(id)sender {
    [[SettingsManager sharedManager] setHasAcceptedAgreement:true];
    [self performSegueWithIdentifier:@"showWelcomeScreen" sender:self];
}

@end
