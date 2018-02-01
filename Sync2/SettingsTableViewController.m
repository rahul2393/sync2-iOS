//
//  SettingsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "DummySettingsData.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "DataChannelSelectionViewController.h"
#import "ProjectSelectionViewController.h"
@interface SettingsTableViewController ()
@property (nonatomic, readwrite) BOOL useDummyData;
@property (nonatomic, strong) NSArray *dataChannels;
@property (nonatomic, strong) NSArray *projects;
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _useDummyData = NO;
    
    self.title = @"Settings";
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

-(void) loadProjects{
    [[SenseAPI sharedManager] GetProjectsWithCompletion:^(NSArray *projects, NSError * _Nullable error) {
        self.projects = projects;
        dispatch_async(dispatch_get_main_queue(),^{
            [self performSegueWithIdentifier:@"projectSelection" sender:self];
        });
    }];
}

-(void) loadDataChannels{
    [[SenseAPI sharedManager] GetDataChannelsWithCompletion:^(NSArray *dataChannels, NSError * _Nullable error) {
        self.dataChannels = dataChannels;
        dispatch_async(dispatch_get_main_queue(),^{
            [self performSegueWithIdentifier:@"dataChannelSelection" sender:self];
        });
        
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"dataChannelSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        DataChannelSelectionViewController *dcsvc = (DataChannelSelectionViewController *)nav.viewControllers[0];
        dcsvc.channels = self.dataChannels;
    }else if ([segue.identifier isEqualToString:@"projectSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        ProjectSelectionViewController *vc = (ProjectSelectionViewController *)nav.viewControllers[0];
        vc.projects = self.projects;
    }
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
                if (self.useDummyData) {
                    cell.detailTextLabel.text = [[DummySettingsData project] name];
                }else{
                    Project *selected = [[SettingsManager sharedManager] selectedProject];
                    NSString *t = @"";
                    if (selected) {
                        t = selected.name;
                    }
                    cell.detailTextLabel.text = t;
                }
                
            }
                break;
                
            default:{
                cell.textLabel.text = @"Data Channel";
                if (self.useDummyData) {
                    cell.detailTextLabel.text = [[DummySettingsData dataChannel] name];
                }else{
                    DataChannel *selected = [[SettingsManager sharedManager] selectedDataChannel];
                    NSString *t = @"";
                    if (selected) {
                        t = selected.name;
                    }
                    cell.detailTextLabel.text = t;
                }
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
                [self loadProjects];
                break;
                
            default:
                [self loadDataChannels];
                break;
        }
    }
}

- (IBAction)doneButtonTapped:(id)sender {
    
    [self dismissModal];
    
}
@end
