//
//  MasterTabViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MasterTabViewController.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "DataChannelSelectionViewController.h"
#import "ProjectSelectionViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SDKManager.h"

@import SixgillSDK;
@interface MasterTabViewController ()

@property (nonatomic, strong) NSArray *dataChannels;
@property (nonatomic, strong) NSArray *projects;

@end

@implementation MasterTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SGSDK registerForSensorUpdates:self];
}

- (void)dealloc
{
    [SGSDK registerForSensorUpdates:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkCurrentAccountState];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![[SettingsManager sharedManager] currentAccountEmail]) {
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
        return;
    }
    
}

-(void) checkCurrentAccountState{
    if (![[SettingsManager sharedManager] currentAccountEmail]) {
        return;
    }
    if (![[SettingsManager sharedManager] selectedDataChannel]) {
        [self loadDataChannels];
    }else if (![[SettingsManager sharedManager] selectedProject]) {
        [self loadProjects];
    }
}

-(void) loadDataChannels{
    [[SenseAPI sharedManager] GetDataChannelsWithCompletion:^(NSArray *dataChannels, NSError * _Nullable error) {
        self.dataChannels = dataChannels;
        
        dispatch_async(dispatch_get_main_queue(),^{
            [self performSegueWithIdentifier:@"showDataChannelSelection" sender:self];
        });
        
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDataChannelSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        DataChannelSelectionViewController *dcsvc = (DataChannelSelectionViewController *)nav.viewControllers[0];
        dcsvc.channels = self.dataChannels;
    }else if ([segue.identifier isEqualToString:@"showProjectSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        ProjectSelectionViewController *vc = (ProjectSelectionViewController *)nav.viewControllers[0];
        vc.projects = self.projects;
    }
}

-(void) loadProjects{
    [[SenseAPI sharedManager] GetProjectsWithCompletion:^(NSArray *projects, NSError * _Nullable error) {
        self.projects = projects;
        dispatch_async(dispatch_get_main_queue(),^{
            [self performSegueWithIdentifier:@"showProjectSelection" sender:self];
        });
        
    }];
}

- (void)sensorUpdateSentWithData:(Event *)sensorData {
    [[SDKManager sharedManager] setSensorsData:sensorData];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sensorDataUpdated" object:self];
    
}


@end
