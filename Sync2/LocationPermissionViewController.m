//
//  LocationPermissionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/30/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LocationPermissionViewController.h"

@interface LocationPermissionViewController ()

@end

@implementation LocationPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)enableLocationTapped:(id)sender {
    
    [self.parentPageViewController next];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}
@end
