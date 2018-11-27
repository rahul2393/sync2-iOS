//
//  WelcomeViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/25/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SettingsManager.h"
#import "WebViewController.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)haveAccountTapped:(id)sender {
    [self performSegueWithIdentifier:@"showPermissionRequests" sender:self];
}


- (IBAction)createNewAccountTapped:(id)sender {
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.titleString = @"Sign Up";
    webVC.urlString = @"https://www.sixgill.com/sign-up-dev/";
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webVC];
    [navController.navigationBar setBarTintColor:[[UIColor alloc] initWithRed:2.0/255.0 green:44.0/255.0 blue:106.0/255.0 alpha:1]];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName , nil];
    navController.navigationBar.titleTextAttributes = attributes;
    
    [self presentViewController:navController animated:true completion:nil];
    
}


@end
