//
//  EULAViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 20/03/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "EULAViewController.h"
#import "SettingsManager.h"

@interface EULAViewController ()

@end

@implementation EULAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)declineAgreement:(id)sender {
}

- (IBAction)acceptAgreement:(id)sender {
    [self performSegueWithIdentifier:@"showTermsOfService" sender:self];
}

@end

