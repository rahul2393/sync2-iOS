//
//  MapSettingsViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/22/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MapSettingsViewController.h"
#import "SettingsManager.h"
@interface MapSettingsViewController ()
@end

@implementation MapSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Map Settings";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

-(SwitchCell *) switchCellForTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
    
    if (cell == nil) {
        cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"switchCell"];
    }
    cell.activeSwitch.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    [cell.activeSwitch setOn: [[SettingsManager sharedManager] mapShowGeofences]];
        
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self switchCellForTableView:tableView andIndexPath:indexPath];
    cell.textLabel.text = @"Display Project Landmarks";
    
    return cell;
    
}

-(void)activeSwitchToggled:(BOOL)state withTag:(NSInteger)tag{
    
    NSLog(@"Switch switched");
    [[SettingsManager sharedManager] setMapShowGeofences:state];
}


@end
