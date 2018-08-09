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
#import "SDKManager.h"
#import "DataChannelSelectionViewController.h"
#import "ProjectSelectionViewController.h"
#import "EnvironmentSelectionViewController.h"
#import "EnvironmentManager.h"
#import "SettingsTableViewCell.h"

@import SixgillSDK;

@interface SettingsTableViewController ()
@property (nonatomic, readwrite) BOOL useDummyData;
@property (nonatomic, strong) NSArray *dataChannels;
@property (nonatomic, strong) NSArray *projects;
@property NSDictionary* log;
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _useDummyData = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.log = [[SDKManager sharedManager] sensorsData].lastObject;
    [self.tableView reloadData];
}

-(void) loadEnvironments{
    [self performSegueWithIdentifier:@"goToEnvironmentSelection" sender:self];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-20, 28)];
    labelView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelView.frame];
    [label setFont:[UIFont systemFontOfSize:14]];

    if (section == 0) {
        label.text = @"Account";
    } else {
        label.text = @"Device Info";
    }

    [labelView addSubview:label];
    
    return labelView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 28)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 28;
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
//    else if([segue.identifier isEqualToString:@"goToEnvironmentSelection"]){
//        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
//        EnvironmentSelectionViewController *vc = (EnvironmentSelectionViewController *)nav.viewControllers[0];
//        vc.settingsVC = self;
//    }
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
            return 4;
        default:
            return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"SettingsTableViewCellIdentifier" forIndexPath:indexPath];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                cell.keyLabel.text = @"Logged-In Email";
                NSString *email = [[SettingsManager sharedManager] currentAccountEmail];
                if (!email) {
                    email = @"";
                }
                cell.valueLabel.text = email;
                break;
            }
            case 1:{
                cell.keyLabel.text = @"Project";
                if (self.useDummyData) {
                    cell.valueLabel.text = [[DummySettingsData project] name];
                }else{
                    Project *selected = [[SettingsManager sharedManager] selectedProject];
                    NSString *t = @"";
                    if (selected) {
                        t = selected.name;
                    }
                    cell.valueLabel.text = t;
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case 2:{
                cell.keyLabel.text = @"Data Channel";
                if (self.useDummyData) {
                    cell.valueLabel.text = [[DummySettingsData dataChannel] name];
                }else{
                    DataChannel *selected = [[SettingsManager sharedManager] selectedDataChannel];
                    NSString *t = @"";
                    if (selected) {
                        t = selected.name;
                    }
                    cell.valueLabel.text = t;
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case 3:{
                cell.keyLabel.text = @"API URL";
                cell.valueLabel.text = [SenseAPI serverAddress];
                break;
            }
            default:{
                break;
            }
        }
    }else{
        
        switch (indexPath.row) {
            case 0: {
                cell.keyLabel.text = @"Device ID";
                cell.valueLabel.text = self.log[@"device-info-guid"];
                break;
            }
            case 1: {
                cell.keyLabel.text = @"Device Type";
                break;
            }
            case 2: {
                cell.keyLabel.text = @"Manufacturer";
                cell.valueLabel.text = self.log[@"device-info-platform"];
                break;
            }
            case 3: {
                cell.keyLabel.text = @"Model";
                cell.valueLabel.text = self.log[@"device-info-model"];
                break;
            }
            case 4: {
                cell.keyLabel.text = @"OS Version";
                cell.valueLabel.text = self.log[@"device-info-osversion"];
                break;
            }
            case 5: {
                cell.keyLabel.text = @"Software Version";
                break;
            }
            default:
                break;
        }
        
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
                
            case 2:
                // Open channel selection view
                [self loadDataChannels];
                break;
                
            default:
                break;
        }
    }
//    else{
//        [self loadEnvironments];
//    }
}


-(void) logout{
    [[SettingsManager sharedManager] logout];
    [[SDKManager sharedManager] stopSDK];
    [self dismissModal];
}

- (IBAction)logoutTapped:(id)sender {
    
    [self logout];
}
@end
