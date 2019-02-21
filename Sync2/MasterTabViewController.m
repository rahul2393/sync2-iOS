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
#import "OrganizationSelectionViewController.h"
#import "DataChannelSelectionViewController.h"
#import "ProviderKeysViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SDKManager.h"

@import SixgillSDK;
@interface MasterTabViewController ()

@property (nonatomic, strong) NSArray *dataChannels;
@property (nonatomic, strong) NSArray *organizations;

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
    if (![[SettingsManager sharedManager] selectedOrganization]) {
        [self loadOrganizations];
    }else if (![[SettingsManager sharedManager] selectedDataChannel]) {
        [self loadDataChannels];
    } else if (![[SettingsManager sharedManager] providerApiKey]) {
        
        dispatch_async(dispatch_get_main_queue(),^{
            [self performSegueWithIdentifier:@"showSetProviderKey" sender:self];
        });
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
        dcsvc.shouldFilterHailerType = false;
    }else if ([segue.identifier isEqualToString:@"showOrganizationSelection"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        OrganizationSelectionViewController *vc = (OrganizationSelectionViewController *)nav.viewControllers[0];
        vc.organizations = self.organizations;
    }else if ([segue.identifier isEqualToString:@"showSetProviderKey"]) {
//        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
//        ProviderKeysViewController *vc = (ProviderKeysViewController *)nav.viewControllers[0];
    }
}

-(void) loadOrganizations{
    [[SenseAPI sharedManager] GetOrganizationsWithCompletion:^(NSArray *orgs, NSError * _Nullable error) {
        self.organizations = orgs;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"showOrganizationSelection" sender:self];
        });
    }];
}

- (void)sensorUpdateSentWithData:(Event *)sensorData {
    [[SDKManager sharedManager] setSensorsData:sensorData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sensorDataUpdated" object:self];
}


@end
