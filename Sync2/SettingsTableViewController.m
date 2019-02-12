//
//  SettingsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "SDKManager.h"
#import "DataChannelSelectionViewController.h"
#import "EnvironmentSelectionViewController.h"
#import "EnvironmentManager.h"
#import "SettingsTableViewCell.h"

@import SixgillSDK;

@interface SettingsTableViewController ()
@property (nonatomic, strong) NSArray *dataChannels;
@property (nonatomic, readwrite) BOOL loadDataChannelsForHailerType;
@property Event* log;
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

-(void) loadDataChannelsForHailerType:(BOOL)loadDataChannelsForHailerType{
    [[SenseAPI sharedManager] GetDataChannelsWithCompletion:^(NSArray *dataChannels, NSError * _Nullable error) {
        self.dataChannels = dataChannels;
        self.loadDataChannelsForHailerType = loadDataChannelsForHailerType;
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
        dcsvc.shouldFilterHailerType = self.loadDataChannelsForHailerType;
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
            return 3;
        default:
            return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"SettingsTableViewCellIdentifier" forIndexPath:indexPath];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.valueLabel.enableCopy = false;
    
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
                cell.keyLabel.text = @"Data Channel";
                DataChannel *selected = [[SettingsManager sharedManager] selectedDataChannel];
                NSString *t = @"";
                if (selected) {
                    t = selected.name;
                }
                cell.valueLabel.text = t;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case 3:{
                cell.keyLabel.text = @"Hailer Channel";
                DataChannel *selected = [[SettingsManager sharedManager] selectedHailerChannel];
                NSString *t = @"";
                if (selected) {
                    t = selected.name;
                }
                cell.valueLabel.text = t;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            }
            case 4:{
                cell.keyLabel.text = @"API URL";
                cell.valueLabel.text = [SenseAPI serverAddress];
                break;
            }
            default:{
                break;
            }
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                cell.keyLabel.text = @"Device ID";
                cell.valueLabel.text = [SGSDK deviceId];
                cell.valueLabel.enableCopy = true;
                break;
            }
            case 1: {
                cell.keyLabel.text = @"Device Type";
                cell.valueLabel.text = self.log.properties.type;
                break;
            }
            case 2: {
                cell.keyLabel.text = @"Manufacturer";
                cell.valueLabel.text = self.log.properties.manufacturer;
                break;
            }
            case 3: {
                cell.keyLabel.text = @"Model";
                cell.valueLabel.text = self.log.properties.model;
                break;
            }
            case 4: {
                cell.keyLabel.text = @"OS Version";
                cell.valueLabel.text = self.log.properties.osVersion;
                break;
            }
            case 5: {
                cell.keyLabel.text = @"Build Version";
                NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
                cell.valueLabel.text = [NSString stringWithFormat:@"%@ (%@)", version, build];
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
                // Open channel selection view
                [self loadDataChannelsForHailerType:false];
                break;
            case 3:
                // Open channel selection view
                [self loadDataChannelsForHailerType:true];
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

- (IBAction)forceSensorUpdateTapped:(UIButton *)sender {
    [SGSDK forceSensorUpdate];
}

- (IBAction)onDemandLocationUpdateTapped:(UIButton *)sender {
    [SGSDK getLocationWithSuccessHandler:^(Location *location) {
        NSString *locMessage = [NSString stringWithFormat:@"\nLatitude: %f\nLongtitude: %f\nAccuracy: %f", location.latitude, location.longitude, location.accuracy];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location Update" message:locMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:true completion:nil];
    } andFailureHandler:^(Error *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.errorMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:true completion:nil];
    }];
}

- (IBAction)logoutTapped:(id)sender {
    
    [self logout];
}
@end
