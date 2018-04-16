//
//  WelcomeViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/25/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SettingsManager.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![[SettingsManager sharedManager] hasOnboarded]) {
        [self performSegueWithIdentifier:@"showLicenseAgreement" sender:self];
    }else if ([[SettingsManager sharedManager] currentAccountEmail]) {
        [self performSegueWithIdentifier:@"alreadySignedIn" sender:self];
    }
}

- (IBAction)haveAccountTapped:(id)sender {
    
}


- (IBAction)createNewAccountTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"goToSignupView" sender:self];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sixgill.com"]];
}


@end
