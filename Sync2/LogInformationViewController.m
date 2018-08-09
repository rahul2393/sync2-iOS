//
//  LogInformationViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 05/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogInformationViewController.h"
#import "LogMapDataViewController.h"

@interface LogInformationViewController ()

@end

@implementation LogInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Log Information";
    
    [self.mapView setUserInteractionEnabled:NO];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.event[@"device-timestamp"] doubleValue] / 1000.0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a, MMMM dd, yyyy"];
    self.dateTImeLabel.text = [dateFormatter stringFromDate:date];
    
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[self.event[@"lat"] doubleValue] longitude: [self.event[@"lon"] doubleValue]];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:10];
    self.mapView.camera = camera;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = currentLocation.coordinate;
    marker.map = self.mapView;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LogInformationSegueIdentifier"]) {
        LogMapDataViewController* vc = [segue destinationViewController];
        vc.event = _event;
    }
}


@end
