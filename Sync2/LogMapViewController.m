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
#import "SenseAPI.h"
#import "ProjectLandmark.h"
#import "SettingsManager.h"
#import "UIView+Toast.h"

@import SixgillSDK;

#define kLogsButtonLabel @"Copy All Logs"

@interface LogMapViewController ()
@property (nonatomic, strong) LogMapDataViewController* vc;
@property (nonatomic, readwrite) NSInteger currentIndex;
@property GMSMarker* marker;
@property GMUHeatmapTileLayer* heatmapLayer;
@property (nonatomic, strong) NSArray *landmarks;
-(void) handleShowPrevNextButtons;
-(void) showEmptyView;
-(void) showLogsView;
-(void) createHeatMap;
@end

@implementation LogMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.marker = [[GMSMarker alloc] init];
    [self.mapView setUserInteractionEnabled:NO];
    
    self.zoomControls.mapView = self.mapView;
    
    self.heatmapLayer = [[GMUHeatmapTileLayer alloc] init];
    self.heatmapLayer.map = self.mapView;
    self.heatmapLayer.opacity = 1.0;
    
    self.currentIndex = 0;
    
    // Setting view constraints
    switch (UIDevice.currentDevice.screenType) {
        case iPhoneX:
            self.viewHeightConstraint.constant = 1615;
            break;
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            self.viewHeightConstraint.constant = 1555;
            break;
        case iPhones_6_6s_7_8:
        case iPhones_5_5s_5c_SE:
            self.viewHeightConstraint.constant = 1554;
        default:
            break;
    }
    
    [self loadLandmarks];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LogMapSegueIdentifier"]) {
        _vc = [segue destinationViewController];
        _vc.event = [[[SDKManager sharedManager] sensorsData].lastObject copy];
        _vc.buttonLabelText = kLogsButtonLabel;
        _vc.delegate = self;
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    Event *currentEvent = self.logs[self.currentIndex];
    _vc.event = [currentEvent copy];
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
    if (self.logs == nil || self.logs.count == 1) {
        [self.prevMapButton setHidden:YES];
        [self.nextMapButton setHidden:YES];
    } else if (_currentIndex == 0) {
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.heatmapLayer.map = nil;
    });
    
    for(Event *event in self.logs) {
        CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:event.locationsArray[0].latitude longitude: event.locationsArray[0].longitude];
        GMUWeightedLatLng* coords = [[GMUWeightedLatLng alloc] initWithCoordinate:currentLocation.coordinate intensity:1.0];
        [list addObject:coords];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        self.heatmapLayer.weightedData = list;
        self.heatmapLayer.map = self.mapView;
    });

    [self drawLandmarks];
}

#pragma mark - IBAction

- (IBAction)showNextMap:(id)sender {
    if (self.logs.count > self.currentIndex) {
        self.currentIndex += 1;
    }
}

- (IBAction)showPrevMap:(id)sender {
    self.currentIndex -= 1;
}

- (IBAction)datePickerTapped:(id)sender {
    [self datesSelected:sender onSuccessHandler:^{
        if (self.logs.count > 0) {
            self.currentIndex = 0;
        }
    }];
}

#pragma mark - LogMapDataDelegate

- (void)logsButtonTapped {
    UIPasteboard *board = UIPasteboard.generalPasteboard;

    NSString *eventsString = @"[";
    for (Event *log in self.logs) {
        eventsString = [eventsString stringByAppendingString:[NSString stringWithFormat:@"%@", log]];
    }
    eventsString = [eventsString stringByAppendingString:@"]"];
    board.string = eventsString;
    
    [self.view makeToast:@"All Logs Copied" duration:3.0 position:CSToastPositionCenter];
}

#pragma mark - LogBaseViewController

- (void)logsChanged {
    [super logsChanged];
    if (self.logs.count == 0) {
        [self showEmptyView];
        return;
    }
    
    [self showLogsView];
    
    [self createHeatMap];
    self.currentIndex = 0;
}

- (void)updateDateLabel {
    [super updateDateLabel];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dateTimePickerLabel.text = [NSString stringWithFormat:@"%@-%@", [self.dateLabelFormatter  stringFromDate:self.fromDate], [self.dateLabelFormatter  stringFromDate:self.toDate]];
    });
}

- (void)updateViewWithSensorData {
    [super updateViewWithSensorData];
    [self filterLogList];
    Event *recentLog = [[SDKManager sharedManager] sensorsData].firstObject;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(recentLog.timestamp / 1000.0)];
    
    if([date compare: self.fromDate] == NSOrderedDescending &&  [date compare:self.toDate] == NSOrderedAscending) {
        if (self.logs.count == (self.currentIndex +1) ) {
            self.currentIndex = 0;
        } else if (self.logs.count > (self.currentIndex+1)) {
            self.currentIndex += 1;
        }
    }
}

- (void) loadLandmarks{
    [[SenseAPI sharedManager] GetLandmarksWithCompletion:^(NSArray *landmarks, NSError * _Nullable error) {
        self.landmarks = landmarks;
        
        [self drawLandmarks];
    }];
}

-(void) drawLandmarks{

    for (ProjectLandmark *lm in self.landmarks) {
        if ([lm.geometryType isEqualToString:@"circle"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSCircle *p = [lm googleMkCircle];
                p.map = self.mapView;
            });
        }else if([lm.geometryType isEqualToString:@"envelope"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSPolygon *p = [lm googleMkRect];
                p.map = self.mapView;
            });
        }else if([lm.geometryType isEqualToString:@"polygon"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSPolygon *p = [lm googleMkPolygon];
                p.map = self.mapView;
            });
        }
    }
}

@end
