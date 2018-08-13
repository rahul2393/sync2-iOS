//
//  SplashViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 17/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SplashViewController.h"
#import "SettingsManager.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [_spinner setTransform:CGAffineTransformRotate(_spinner.transform, (10*(M_PI_2)))];
    }completion:^(BOOL _){
        if (![[SettingsManager sharedManager] hasAcceptedAgreement]) {
            [self performSegueWithIdentifier:@"showLicenseAgreement" sender:self];
        } else if (![[SettingsManager sharedManager] hasOnboarded]) {
            [self performSegueWithIdentifier:@"showWelcomeScreen" sender:self];
        } else if (![[SettingsManager sharedManager] currentAccountEmail]){
            [self performSegueWithIdentifier:@"goToLoginView" sender:self];
        } else {
            [self performSegueWithIdentifier:@"alreadySignedIn" sender:self];
        }
    }];
}

@end
