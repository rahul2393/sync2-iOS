//
//  LogMapDataViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 05/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogMapDataViewController.h"
#import "LogMapTableViewCell.h"

@import SixgillSDK;

@interface LogMapDataViewController ()

@end

@implementation LogMapDataViewController

- (void)setEvent:(Event *)event {
    _event = event;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [_logsButton setTitle:_buttonLabelText forState:UIControlStateNormal];
}

- (IBAction)logsButtonTapped:(id)sender {
    [self.delegate logsButtonTapped];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogMapTableViewCell *cell = (LogMapTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LogMapTableViewCellIdentifier" forIndexPath:indexPath];
    cell.valueLabel.enableCopy = false;
    switch (indexPath.row) {
        case 0: {
            cell.nameLabel.text = @"Device ID";
            if (_event != nil) {
                cell.valueLabel.text = [SGSDK deviceId];
                cell.valueLabel.enableCopy = true;
            }
            break;
        }
        case 1: {
            cell.nameLabel.text = @"Activity";
            if (_event != nil) {
                cell.valueLabel.text = _event.activitiesArray[0].type;
            }
            break;
        }
        case 2: {
            cell.nameLabel.text = @"Location";
            if (_event != nil && _event.locationsArray[0].latitude &&  _event.locationsArray[0].longitude) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%f, %f", _event.locationsArray[0].latitude, _event.locationsArray[0].longitude];;
            } else {
                cell.valueLabel.text = @"-";
            }
            break;
        }
        case 3: {
            cell.nameLabel.text = @"Cadence";
            if (_event != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%lld seconds", (_event.configurations.cadence/1000)];;
            }
            break;
        }
        case 4: {
            cell.nameLabel.text = @"Wifi";
            cell.valueLabel.text = self.event.wifisArray[0].ssid;
            break;
        }
        case 5: {
            cell.nameLabel.text = @"Battery";
            if (_event != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%lld%%", _event.powersArray[0].batteryLife];;
            }
            break;
        }
        case 6: {
            cell.nameLabel.text = @"Beacons-In-Range";
            if (_event != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%lu", (unsigned long)_event.ibeaconsArray.count];;
            }
            break;
        }
        case 7: {
            cell.nameLabel.text = @"Geofences";
            break;
        }
        case 8: {
            cell.nameLabel.text = @"Steps Count";
            if (_event != nil) {
                NSDictionary *attributes = _event.attributes;
                if ([attributes objectForKey:@"STEPS"]) {
                    cell.valueLabel.text = attributes[@"STEPS"];
                }
            }
            break;
        }
        case 9: {
            cell.nameLabel.text = @"Distance";
            if (_event != nil) {
                NSDictionary *attributes = _event.attributes;
                if ([attributes objectForKey:@"DISTANCE"]) {
                    CGFloat distance = [attributes[@"DISTANCE"] floatValue];
                    cell.valueLabel.text = [NSString stringWithFormat:@"%.02f meters", distance];
                }
            }
            break;
        }
        case 10: {
            cell.nameLabel.text = @"Floors Ascended";
            if (_event != nil) {
                NSDictionary *attributes = _event.attributes;
                if ([attributes objectForKey:@"FLOORS-ASCENDED"]) {
                    cell.valueLabel.text = attributes[@"FLOORS-ASCENDED"];
                }
            }
            break;
        }
        case 11: {
            cell.nameLabel.text = @"Floors Descended";
            if (_event != nil) {
                NSDictionary *attributes = _event.attributes;
                if ([attributes objectForKey:@"FLOORS-DESCENDED"]) {
                    cell.valueLabel.text = attributes[@"FLOORS-DESCENDED"];
                }
            }
            break;
        }
        case 12: {
            cell.nameLabel.text = @"Floor Level";
            if (_event != nil) {
                NSDictionary *attributes = _event.attributes;
                if ([attributes objectForKey:@"floorLevel"]) {
                    cell.valueLabel.text = attributes[@"floorLevel"];
                }
            }
            break;
        }
        case 13: {
            cell.nameLabel.text = @"Provider Type";
            if (_event != nil) {
                NSDictionary *attributes = _event.attributes;
                if ([attributes objectForKey:@"type"]) {
                    cell.valueLabel.text = attributes[@"type"];
                }
            }
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
