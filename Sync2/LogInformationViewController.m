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
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(self.event.timestamp / 1000.0)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a, MMMM dd, yyyy"];
    self.dateTImeLabel.text = [dateFormatter stringFromDate:date];
    
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.event.locationsArray[0].latitude longitude: self.event.locationsArray[0].longitude];
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
        vc.buttonLabelText = @"Copy Log";
        vc.delegate = self;
    }
}

- (void)logsButtonTapped {
    UIPasteboard *board = UIPasteboard.generalPasteboard;
    board.string = [NSString stringWithFormat:@"%@", self.event];
}

@end
