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

- (void)sensorUpdateSentWithData:(NSDictionary *)sensorData {
    
        NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
    
        if (sensorData[@"SG_LOCATION_RESOURCE"]) {
            
            CLLocation *loc = sensorData[@"SG_LOCATION_RESOURCE"][@"location"];
            NSNumber *lat = [NSNumber numberWithFloat:loc.coordinate.latitude];
            NSNumber *lon = [NSNumber numberWithFloat:loc.coordinate.longitude];
            event[@"lat"] = lat;
            event[@"lon"] = lon;
            event[@"location-timestamp"] = loc.timestamp;
        }
        
        if (sensorData[@"SG_ACTIVITY_RESOURCE"]) {
            
            event[@"activity"] = sensorData[@"SG_ACTIVITY_RESOURCE"][@"activity"];
            event[@"activity-timeStamp"] = sensorData[@"SG_ACTIVITY_RESOURCE"][@"timestamp"];
        }
        
        if (sensorData[@"SG_BLUETOOTH_RESOURCE"]) {
            
            event[@"bluetooth-beacons"] = sensorData[@"SG_BLUETOOTH_RESOURCE"][@"beacons"];
            event[@"bluetooth-timeStamp"] = sensorData[@"SG_BLUETOOTH_RESOURCE"][@"timestamp"];
        }
        
        if (sensorData[@"SG_CONFIGURATION_RESOURCE"]) {
            
            event[@"configuration-cadence"] = sensorData[@"SG_CONFIGURATION_RESOURCE"][@"cadence"];
            event[@"configuration-enabled"] = sensorData[@"SG_CONFIGURATION_RESOURCE"][@"enabled"];
            event[@"configuration-eventTtl"] = sensorData[@"SG_CONFIGURATION_RESOURCE"][@"eventTtl"];
            event[@"configuration-maxStorage"] = sensorData[@"SG_CONFIGURATION_RESOURCE"][@"maxStorage"];
            event[@"configuration-useSensorsArray"] = sensorData[@"SG_CONFIGURATION_RESOURCE"][@"useSensorsArray"];
        }
        
        if (sensorData[@"SG_DEVICE_RESOURCE"]) {
            
            event[@"device-battery-percent"] = sensorData[@"SG_DEVICE_RESOURCE"][@"BATTERY_PERCENT"];
            event[@"device-battery-state"] = sensorData[@"SG_DEVICE_RESOURCE"][@"BATTERY_STATE"];
            event[@"device-info-guid"] = sensorData[@"SG_DEVICE_RESOURCE"][@"DEVICE_INFO"][@"GUID"];
            event[@"device-info-model"] = sensorData[@"SG_DEVICE_RESOURCE"][@"DEVICE_INFO"][@"MODEL"];
            event[@"device-info-osversion"] = sensorData[@"SG_DEVICE_RESOURCE"][@"DEVICE_INFO"][@"OSVERSION"];
            event[@"device-info-platform"] = sensorData[@"SG_DEVICE_RESOURCE"][@"DEVICE_INFO"][@"PLATFORM"];
            event[@"device-pushToken"] = sensorData[@"SG_DEVICE_RESOURCE"][@"PUSH_TOKEN"];
            event[@"device-timestamp"] = sensorData[@"SG_DEVICE_RESOURCE"][@"timestamp"];
        }
    
    [[SDKManager sharedManager] setSensorsData:event];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sensorDataUpdated" object:self];
    
}


@end
