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
    return 8;
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
                cell.valueLabel.text = [NSString stringWithFormat: @"%lld seconds", _event.configurations.cadence];;
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
            break;
        }
        case 7: {
            cell.nameLabel.text = @"Geofences";
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
