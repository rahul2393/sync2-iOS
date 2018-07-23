//
//  LocationPermissionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/30/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LocationPermissionViewController.h"
@import SixgillSDK;
@interface LocationPermissionViewController ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation LocationPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
                
            case 1136:
                _skipButtonBottomConstraint.constant = 0.5;
                break;
            default:
                _skipButtonBottomConstraint.constant = 32.5;
        }
    }
}

- (IBAction)enableLocationTapped:(id)sender {
    
    _locationManager.delegate = self;
    //[_locationManager requestAlwaysAuthorization];
    [SGSDK requestAlwaysPermission];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    [self.parentPageViewController next];
}
@end
