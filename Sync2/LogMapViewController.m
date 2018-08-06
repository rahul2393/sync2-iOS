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

@import SixgillSDK;

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
}

- (void)setLogs:(NSArray *)logs {
    
    if (logs.count == 0) {
        [self showEmptyView];
        return;
    }
    [self showLogsView];
    
    _logs = logs;
    
    [self createHeatMap];
    
    self.currentIndex = 0;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    NSDictionary *currentEvent = self.logs[self.currentIndex];
    _vc.event = currentEvent;
    
    NSDate *date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:currentEvent[@"location-timestamp"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a, MMMM dd, yyyy"];
    self.dateTimeLabel.text = [dateFormatter stringFromDate:date];
    
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[currentEvent[@"lat"] doubleValue] longitude: [currentEvent[@"lon"] doubleValue]];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:10];
    self.mapView.camera = camera;

    // Creates a marker in the center of the map.
    self.marker.position = currentLocation.coordinate;
    self.marker.map = self.mapView;
    
    [self handleShowPrevNextButtons];
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
        _vc.event = [SGSDK sensorUpdateHistory:100].lastObject;
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
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        }
        origin:sender];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    }
    origin:sender];
}

- (void)updateDateLabel {
    _dateTimePickerLabel.text = [NSString stringWithFormat:@"%@-%@", [_dateLabelFormatter  stringFromDate:_fromDate], [_dateLabelFormatter  stringFromDate:_toDate]];
}

- (void)filterLogList {
    
    self.logs = [[SGSDK sensorUpdateHistory:100] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDate *date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:evaluatedObject[@"location-timestamp"]];
        
        if([date compare: _fromDate] == NSOrderedDescending &&  [date compare:_toDate] == NSOrderedAscending) {
            return true;
        }
        return false;
    }]];
    
    [self updateDateLabel];
}

- (void)showEmptyView {
    [self.noLogsView setHidden:NO];
    [self.mapDisplayView setHidden:YES];
    [self.mapDataView setHidden:YES];
}

- (void)showLogsView {
    [self.noLogsView setHidden:YES];
    [self.mapDisplayView setHidden:NO];
    [self.mapDataView setHidden:NO];
}

- (void)createHeatMap {
    NSMutableArray *list = [[NSMutableArray alloc] init];
//    var list = [GMUWeightedLatLng]()
    
    for(NSDictionary *event in self.logs) {
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:[event[@"lat"] doubleValue] longitude: [event[@"lon"] doubleValue]];
        GMUWeightedLatLng* coords = [[GMUWeightedLatLng alloc] initWithCoordinate:currentLocation.coordinate intensity:1.0];
        [list addObject:coords];
    }
    self.heatmapLayer.weightedData = list;
    self.heatmapLayer.map = self.mapView;

}

@end
