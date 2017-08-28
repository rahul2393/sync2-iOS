
//
//  AccountDetailTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "AccountDetailTableViewController.h"
#import "SettingsManager.h"

@import CoreLocation;
@interface AccountDetailTableViewController ()
@property (nonatomic, strong) NSDictionary *dataSourceSectionData;
@property (nonatomic, strong) NSArray *dataSourceSectionLabels;
@property (nonatomic, strong) NSDictionary *sensorData;
@property (nonatomic, strong) NSDate *sensorUpdateTime;
@end

@implementation AccountDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.dataSourceSectionLabels){
        self.dataSourceSectionLabels = @[@"",
                                         @"Data"];
    }
    
    
    if(!self.dataSourceSectionData){
        self.dataSourceSectionData = @{@"":@[@"Active Account"],
                                       @"Data": @[@"Activity",
                                                  @"Location",
                                                  @"Cadence",
                                                  @"Wifi",
                                                  @"Battery",
                                                  @"Beacons In-Range",
                                                  @"Geofences",
                                                  @"Last update sent"]};
    }
    
    if (!self.sensorData) {
        self.sensorData = @{};
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.accountObject isActiveAccount]) {
        [[SDKManager sharedManager] setSensorDataDelegate:self];
        [[SDKManager sharedManager] forceUpdate];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[SDKManager sharedManager] setSensorDataDelegate:nil];

}

-(void) showLogsView{
    [self performSegueWithIdentifier:@"goToLogView" sender:self];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = self.accountObject.accountName;
    UIBarButtonItem *logsButton = [[UIBarButtonItem alloc]initWithTitle:@"Logs" style:UIBarButtonItemStylePlain target:self action:@selector(showLogsView)];
    self.navigationItem.rightBarButtonItem = logsButton;

}

-(NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath{
    NSString *k = self.dataSourceSectionLabels[indexPath.section];
    NSArray *v = self.dataSourceSectionData[k];
    if (!v) {
        return @"";
    }
    
    return v[indexPath.row];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSourceSectionLabels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *a = self.dataSourceSectionData[self.dataSourceSectionLabels[section]];
    
    if (a) {
        return a.count;
        
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
            if (cell == nil) {
                cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"switchCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            
            if ([self.accountObject isActiveAccount]) {
                [cell.activeSwitch setOn:YES];
            }else{
                [cell.activeSwitch setOn:NO];
            }
            
            return cell;
        }
            break;
            
        default:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [self cellTitleForIndexPath:indexPath];
            
//            @"Data": @[@"Activity",
//                       @"Location",
//                       @"Cadence",
//                       @"Wifi",
//                       @"Battery",
//                       @"Beacons In-Range",
//                       @"Geofences",
//                       @"Last update sent"]};

            
            switch (indexPath.row) {
                case 0:
                    cell.detailTextLabel.text = [self activityString];
                    break;
                case 1:
                    cell.detailTextLabel.text = [self locationString];
                    break;
                case 2:
                    cell.detailTextLabel.text = [self cadenceString];
                    break;
                case 3:
                    cell.detailTextLabel.text = [self wifiString];
                    break;
                case 4:
                    cell.detailTextLabel.text = [self batteryString];
                    break;
                case 5:
                    cell.detailTextLabel.text = [self beaconsString];
                    break;
                case 6:
                    cell.detailTextLabel.text = [self geofencesString];
                    break;
                default:
                    cell.detailTextLabel.text = [self lastUpdateSentString];
                    break;
            }
            
            return cell;
        }
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.dataSourceSectionLabels[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        // Location
        
        [self performSegueWithIdentifier:@"showMapView" sender:self];
    }
}

-(void) activateAccount{
    [[SDKManager sharedManager] stopSDK];
    [[SDKManager sharedManager] clearLogs];
    [[SDKManager sharedManager] startSDKWithAPIKey:self.accountObject.apiKey];
    [[SDKManager sharedManager] setSensorDataDelegate:self];
    [[SettingsManager sharedManager] setActiveAccountId:self.accountObject.accountId];
    [[SDKManager sharedManager] forceUpdate];
}

-(void) deactivateAccount{
    [[SDKManager sharedManager] stopSDK];
    [[SDKManager sharedManager] setSensorDataDelegate:nil];
    [[SettingsManager sharedManager] setActiveAccountId:nil];
}

-(void)sensorUpdateSentWithData:(NSDictionary *)sensorData{
    NSLog(@"Getting data: %@",sensorData.description);
    self.sensorData = sensorData;
    self.sensorUpdateTime = [NSDate date];        
    
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableView reloadData];
    });
    
}

-(void)activeSwitchToggled:(BOOL)state{
    NSLog(@"Switch Toggled");
    
    if (state) {
        [self activateAccount];
    }else{
        [self deactivateAccount];
    }
}


#pragma mark - Sensor Data Strings

-(NSString *)emptyCellString{
    if ([self.accountObject isActiveAccount]) {
        return @"Updating...";
    }else{
        return @"";
    }
}

-(NSString *)activityString{
    if (self.sensorData[@"SG_ACTIVITY_RESOURCE"]) {
        return self.sensorData[@"SG_ACTIVITY_RESOURCE"];
    }
    
    return [self emptyCellString];
}
-(NSString *)locationString{
    if (self.sensorData[@"SG_LOCATION_RESOURCE"]) {
        CLLocation *l = (CLLocation *)self.sensorData[@"SG_LOCATION_RESOURCE"];
        NSString *toReturn = [NSString stringWithFormat:@"%f, %f", l.coordinate.latitude, l.coordinate.longitude];
        return toReturn;
    }
    
    return [self emptyCellString];
    
}

-(NSString *)cadenceString{
    
    if (self.sensorData[@"SG_CONFIGURATION_RESOURCE"]) {
        NSDictionary *d =self.sensorData[@"SG_CONFIGURATION_RESOURCE"];
        
        if (d[@"location_update_cadence"]) {
            NSNumber *cadenceSecondsNum = d[@"location_update_cadence"];
            NSString *toReturn = [NSString stringWithFormat:@"%lu seconds", cadenceSecondsNum.integerValue];
            return toReturn;
        }
    }
    
    return [self emptyCellString];
}

-(NSString *)wifiString{
    if (self.sensorData[@"SG_WIFI_RESOURCE"]) {
        NSDictionary *d =self.sensorData[@"SG_WIFI_RESOURCE"];
        
        if (d[@"SSID"]) {
            NSString *wifiSSID = d[@"SSID"];
            NSString *toReturn = [NSString stringWithFormat:@"%@", wifiSSID];
            return toReturn;
        }
    }
    
    return [self emptyCellString];
}

-(NSString *)batteryString{
    if (self.sensorData[@"SG_DEVICE_RESOURCE"]) {
        NSDictionary *d =self.sensorData[@"SG_DEVICE_RESOURCE"];
        
        if (d[@"BATTERY_PERCENT"]) {
            NSNumber *batteryPercent = d[@"BATTERY_PERCENT"];
            NSString *toReturn = [NSString stringWithFormat:@"%lu%%", batteryPercent.integerValue];
            return toReturn;
        }
    }
    
    return [self emptyCellString];
}

-(NSString *)beaconsString{
    if (self.sensorData[@"SG_BLUETOOTH_RESOURCE"]) {
        NSArray *b =self.sensorData[@"SG_BLUETOOTH_RESOURCE"];
        return [NSString stringWithFormat:@"%lu",b.count];
    }
    return @"0";
}

-(NSString *)geofencesString{
    if (self.sensorData) {
        return @"0";
    }
    return @"";
}

-(NSString *)lastUpdateSentString{
    if (self.sensorData[@"SG_LOCATION_RESOURCE"]) {        
        NSDate *date = _sensorUpdateTime;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeStyle = NSDateFormatterMediumStyle;
        NSString *toReturn = [formatter stringFromDate:date];
        return toReturn;
    }
    return @"Not sent yet";
}


@end
