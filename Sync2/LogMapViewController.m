//
//  LogMapViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogMapViewController.h"
#import "LogMapDataViewController.h"
#import "ActionSheetPicker.h"
#import "Device.h"
#import <GMUHeatmapTileLayer.h>
#import "SDKManager.h"
@import SixgillSDK;

#define kLogsButtonLabel @"Copy All Logs"

@interface LogMapViewController ()
@property (nonatomic, strong) LogMapDataViewController* vc;
@property (nonatomic) NSArray* logs;
@property (nonatomic, readwrite) NSInteger currentIndex;
@property NSDateFormatter *dateLabelFormatter;
@property NSDate* fromDate;
@property NSDate* toDate;
@property GMSMarker* marker;
@property GMUHeatmapTileLayer* heatmapLayer;
-(void) handleShowPrevNextButtons;
-(void) updateDateLabel;
-(void) filterLogList;
-(void) showEmptyView;
-(void) showLogsView;
-(void) createHeatMap;
@end

@implementation LogMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.marker = [[GMSMarker alloc] init];
    [self.mapView setUserInteractionEnabled:NO];
    
    self.heatmapLayer = [[GMUHeatmapTileLayer alloc] init];
    self.heatmapLayer.map = self.mapView;
    self.heatmapLayer.opacity = 1.0;
    
    // Setting initial `from` as today's 12am and `to` date as current time.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    _fromDate = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:[NSDate date] options:0];
    _toDate = [NSDate date];
    
    _dateLabelFormatter = [[NSDateFormatter alloc] init];
    [_dateLabelFormatter setDateFormat:@"MMM dd, h:mm a"];
    [self updateDateLabel];
    
    
    [self filterLogList];
    self.currentIndex = 0;
    
    // Setting view constraints
    switch (UIDevice.currentDevice.screenType) {
        case iPhoneX:
            self.viewHeightConstraint.constant = 1321;
            break;
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            self.viewHeightConstraint.constant = 1261;
            break;
        case iPhones_6_6s_7_8:
        case iPhones_5_5s_5c_SE:
            self.viewHeightConstraint.constant = 1260;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSensorData)
                                                 name:@"sensorDataUpdated"
                                               object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setLogs:(NSArray *)logs {
    
    if (logs.count == 0) {
        [self showEmptyView];
        return;
    }
    [self showLogsView];
    
    _logs = logs;
    
    [self createHeatMap];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    Event *currentEvent = self.logs[self.currentIndex];
    _vc.event = currentEvent;
    _vc.buttonLabelText = kLogsButtonLabel;
    _vc.delegate = self;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(currentEvent.timestamp / 1000.0)];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a, MMMM dd, yyyy"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dateTimeLabel.text = [dateFormatter stringFromDate:date];
    });
    
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:currentEvent.locationsArray[0].latitude longitude: currentEvent.locationsArray[0].longitude];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:10];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.camera = camera;

        // Creates a marker in the center of the map.
        self.marker.position = currentLocation.coordinate;
        self.marker.map = self.mapView;
        
        [self handleShowPrevNextButtons];
    });
}

- (void)handleShowPrevNextButtons {
    if (_currentIndex == 0) {
        [self.prevMapButton setHidden:YES];
        [self.nextMapButton setHidden:NO];
    } else if (_currentIndex == (self.logs.count-1)) {
        [self.prevMapButton setHidden:NO];
        [self.nextMapButton setHidden:YES];
    } else {
        [self.prevMapButton setHidden:NO];
        [self.nextMapButton setHidden:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LogMapSegueIdentifier"]) {
        _vc = [segue destinationViewController];
        _vc.event = [[SDKManager sharedManager] sensorsData].lastObject;
        _vc.buttonLabelText = kLogsButtonLabel;
        _vc.delegate = self;
    }
}

- (IBAction)showNextMap:(id)sender {
    self.currentIndex +=1;
}

- (IBAction)showPrevMap:(id)sender {
    self.currentIndex -=1;
}

- (IBAction)datePickerTapped:(id)sender {
    __block NSDate *localFromDate = nil;
    
    [ActionSheetDatePicker showPickerWithTitle:@"From" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        localFromDate = selectedDate;
        [ActionSheetDatePicker showPickerWithTitle:@"To" datePickerMode:UIDatePickerModeDateAndTime selectedDate:selectedDate minimumDate:selectedDate maximumDate:[NSDate distantFuture] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            _fromDate = localFromDate;
            _toDate = selectedDate;
            [self filterLogList];
            self.currentIndex = 0;
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        }
        origin:sender];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    }
    origin:sender];
}

- (void)updateDateLabel {
    dispatch_async(dispatch_get_main_queue(), ^{
        _dateTimePickerLabel.text = [NSString stringWithFormat:@"%@-%@", [_dateLabelFormatter  stringFromDate:_fromDate], [_dateLabelFormatter  stringFromDate:_toDate]];
    });
}

- (void)filterLogList {
    
    self.logs = [[[SDKManager sharedManager] sensorsData] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Event*  _Nullable log, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(log.timestamp / 1000.0)];
        
        if([date compare: _fromDate] != NSOrderedAscending &&  [date compare:_toDate] != NSOrderedDescending) {
            return true;
        }
        return false;
    }]];
    
    [self updateDateLabel];
}

- (void)updateViewWithSensorData {
    [self filterLogList];
    self.currentIndex += 1;
}

- (void)showEmptyView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.noLogsView setHidden:NO];
        [self.mapDisplayView setHidden:YES];
        [self.mapDataView setHidden:YES];
    });
}

- (void)showLogsView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.noLogsView setHidden:YES];
        [self.mapDisplayView setHidden:NO];
        [self.mapDataView setHidden:NO];
    });
}

- (void)createHeatMap {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    for(Event *event in self.logs) {
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:event.locationsArray[0].latitude longitude: event.locationsArray[0].longitude];
        GMUWeightedLatLng* coords = [[GMUWeightedLatLng alloc] initWithCoordinate:currentLocation.coordinate intensity:1.0];
        [list addObject:coords];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        self.heatmapLayer.weightedData = list;
        self.heatmapLayer.map = self.mapView;
    });

}

- (void)logsButtonTapped {
    
}

@end
