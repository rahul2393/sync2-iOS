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

- (void)setEvent:(NSDictionary *)event {
    _event = event;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

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
            if (_event != nil && _event[@"lat"] != nil  &&  _event[@"lon"] != nil) {
                cell.valueLabel.text = [NSString stringWithFormat: @"%@, %@", _event[@"lat"], _event[@"lon"]];;
            } else {
                cell.valueLabel.text = @"-";
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
