//
//  MapSettingsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/22/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MapSettingsTableViewController.h"
#import "SettingsManager.h"
@interface MapSettingsTableViewController ()
@end

@implementation MapSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Map Settings";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


-(SwitchCell *) switchCellForTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
    
    if (cell == nil) {
        cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"switchCell"];
    }
    cell.activeSwitch.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    switch (indexPath.row) {
        case 0:
            [cell.activeSwitch setOn: [[SettingsManager sharedManager] mapShowGeofences]];
            break;
            
        default:
            [cell.activeSwitch setOn: [[SettingsManager sharedManager] mapShowLast5Pts]];
            break;
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self switchCellForTableView:tableView andIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Display Project Landmarks";
            break;
            
        default:
            cell.textLabel.text = @"Show Last 5 Locations";
            break;
    }
    
    return cell;
    
}

-(void)activeSwitchToggled:(BOOL)state withTag:(NSInteger)tag{
    
    NSLog(@"Switch switched");
    
    switch (tag) {
        case 0:
            [[SettingsManager sharedManager] setMapShowGeofences:state];
            break;
            
        default:
            [[SettingsManager sharedManager] setMapShowLast5Pts:state];
            break;
    }
    
}


@end
