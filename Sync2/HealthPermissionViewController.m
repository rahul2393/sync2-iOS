//
//  HealthPermissionViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 10/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "HealthPermissionViewController.h"
@import SixgillSDK;

@interface HealthPermissionViewController ()
@end

@implementation HealthPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)enableHealthTapped:(id)sender {
    [SGSDK requestHealthKitPermission];
    [self.parentPageViewController next];
}

- (IBAction)skipTapped:(id)sender {
    [self.parentPageViewController next];
}
@end
