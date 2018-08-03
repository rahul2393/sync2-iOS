//
//  LogMapViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogMapViewController.h"
#import "Device.h"
#import "LogMapTableViewCell.h"

@import MapKit;

@import SixgillSDK;

@interface LogMapViewController ()

@end

@implementation LogMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.mapView.delegate = self;
    
    self.mapView.scrollEnabled = false;
    
    
    switch (UIDevice.currentDevice.screenType) {
        case iPhoneX:
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            self.viewHeightConstraint.constant = 1321;
            break;
        case iPhones_6_6s_7_8:
        case iPhones_5_5s_5c_SE:
            self.viewHeightConstraint.constant = 1260;
        default:
            break;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    
    if (_event == nil) {
        _event = [SGSDK sensorUpdateHistory:100].lastObject;
    }
    
    if (_event != nil) {
        CLLocation *initialLocation = [[CLLocation alloc] initWithLatitude:[_event[@"lat"] doubleValue] longitude: [_event[@"lon"] doubleValue]];
        CLLocationDistance regionRadius = 1000;
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius, regionRadius);
        [self.mapView setRegion:coordinateRegion animated:true];
        
        pointAnnotation.coordinate = initialLocation.coordinate;
        [_mapView addAnnotation:pointAnnotation];
    }
    
    [self.tableView reloadData];
}

- (IBAction)viewSDKLogsTapped:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogMapTableViewCell *cell = (LogMapTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LogMapTableViewCellIdentifier" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0: {
            cell.nameLabel.text = @"Device ID";
            if (_event != nil) {
                cell.valueLabel.text = _event[@"device-info-guid"];
            }
            break;
        }
        case 1: {
            cell.nameLabel.text = @"Activity";
            if (_event != nil) {
                cell.valueLabel.text = _event[@"activity"];
            }
            break;
        }
        case 2: {
            cell.nameLabel.text = @"Location";
            if (_event != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%@, %@", _event[@"lat"], _event[@"lon"]];;
            }
            break;
        }
        case 3: {
            cell.nameLabel.text = @"Cadence";
            if (_event != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%@ seconds", _event[@"configuration-cadence"]];;
            }
            break;
        }
        case 4: {
            cell.nameLabel.text = @"Wifi";
            break;
        }
        case 5: {
            cell.nameLabel.text = @"Battery";
            if (_event != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%@%%", _event[@"device-battery-percent"]];;
            }
            break;
        }
        case 6: {
            cell.nameLabel.text = @"Beacons-In-Range";
            cell.valueLabel.text = @"0";
            break;
        }
        case 7: {
            cell.nameLabel.text = @"Geofences";
            cell.valueLabel.text = @"0";
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

@end
