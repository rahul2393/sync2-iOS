//
//  SettingsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "DummySettingsData.h"
@interface SettingsTableViewController ()
@property (nonatomic, readwrite) BOOL useDummyData;
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _useDummyData = YES;
    
    self.title = @"Settings";
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(void) dismissModal{
    
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 3;
        default:
            return 1;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self dummyCellForRowAtIndexPath:indexPath];
}

-(UITableViewCell *) dummyCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"Logged-In Email";
                cell.detailTextLabel.text = [[DummySettingsData account] accountEmail];
                cell.accessoryType = UITableViewCellAccessoryNone;
                break;
            }
            case 1:{
                cell.textLabel.text = @"Project";
                cell.detailTextLabel.text = [[DummySettingsData project] name];
            }
                break;
                
            default:{
                cell.textLabel.text = @"Data Channel";
                cell.detailTextLabel.text = [[DummySettingsData dataChannel] name];
            }
                break;
        }
    }else{
        cell.textLabel.text = @"API URL";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = [DummySettingsData apiURL];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
                // Open project selection view
                [self performSegueWithIdentifier:@"projectSelection" sender:self];
                break;
                
            default:
                [self performSegueWithIdentifier:@"dataChannelSelection" sender:self];
                break;
        }
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self dismissModal];
    
}
@end
