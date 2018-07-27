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

@interface LogMapViewController ()

@end

@implementation LogMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    
    [self.tableView reloadData];
}

- (IBAction)viewSDKLogsTapped:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LogMapTableViewCell *cell = (LogMapTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LogMapTableViewCellIdentifier" forIndexPath:indexPath];
    cell.nameLabel.text = @"A";
    cell.valueLabel.text = @"B";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}


@end
