//
//  RulesInformationCloudViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 30/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "RulesInformationCloudViewController.h"
#import "Device.h"

@interface RulesInformationCloudViewController ()

@end

@implementation RulesInformationCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    switch (UIDevice.currentDevice.screenType) {
        case iPhoneX:
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            self.tableViewHeightConstraint.constant = 406;
            break;
        case iPhones_6_6s_7_8:
            self.tableViewHeightConstraint.constant = 317;
            break;
        case iPhones_5_5s_5c_SE:
            self.tableViewHeightConstraint.constant = 218;
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}

- (IBAction)triggerRuleTapped:(id)sender {
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(10, 4, tableView.frame.size.width-20, 43)];
    labelView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelView.frame];
    [label setFont:[UIFont systemFontOfSize:14]];
    
    switch (section) {
        case 0:
            label.text = @"Rule Condition";
            break;
        case 1:
            label.text = @"Rule Action";
            break;
        case 2:
            label.text = @"Schedule";
            break;
        case 3:
            label.text = @"Triggering Behavior";
            break;
        case 4:
            label.text = @"Tags";
            break;
        default:
            break;
    }
    
    [labelView addSubview:label];
    
    return labelView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 43;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 4;
        case 2:
            return 2;
        case 3:
            return 1;
        case 4:
            return 2;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RulesInformationCellIdentifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RulesInformationCellIdentifier"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"Enter Area";
                    cell.detailTextLabel.text = @"Type";
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"WeWork Office";
                    cell.detailTextLabel.text = @"Landmark";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                }
                case 2: {
                    cell.textLabel.text = @"Instant";
                    cell.detailTextLabel.text = @"Dwell Time";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"Send Notification";
                    cell.detailTextLabel.text = @"Type";
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"Welcome to WeWork";
                    cell.detailTextLabel.text = @"Subject";
                    break;
                }
                case 2: {
                    cell.textLabel.text = @"Have a great day at the office!";
                    cell.detailTextLabel.text = @"Message";
                    break;
                }
                case 3: {
                    cell.textLabel.text = @"All Devices";
                    cell.detailTextLabel.text = @"Recipient";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"9:00 AM, January 1, 2017";
                    cell.detailTextLabel.text = @"Start";
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"-";
                    cell.detailTextLabel.text = @"End";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 3: {
            cell.textLabel.text = @"9:00 AM, January 1, 2017";
            cell.detailTextLabel.text = @"Trigger";
            break;
        }
        case 4: {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"promotions";
                    cell.detailTextLabel.text = @"";
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"messages";
                    cell.detailTextLabel.text = @"";
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    return cell;
}

@end
