//
//  MapViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MapViewController.h"
#import "DummyMapData.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "ProjectLandmark.h"
@import SixgillSDK;
@interface MapViewController ()

@property (nonatomic, strong) NSArray *coords;
@property (nonatomic, strong) NSArray *landmarks;

//@property (nonatomic, readwrite) BOOL showLast5Locs;
@property (nonatomic, readwrite) BOOL showGeo;
@property (nonatomic, readwrite) BOOL useDummyData;

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.useDummyData = NO;
    
    if (!self.coords) {
        self.coords = [DummyMapData coords];
        self.mapView.delegate = self;
    }
    
    if (self.useDummyData) {
        self.landmarks = [DummyMapData geofences];
    }else{
        self.landmarks = @[];
    }
    
    self.title = @"Map";
    
}

- (void) loadLandmarks{
    [[SenseAPI sharedManager] GetLandmarksWithCompletion:^(NSArray *landmarks, NSError * _Nullable error) {
        self.landmarks = landmarks;
        
        [self drawLandmarks];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _showGeo = [[SettingsManager sharedManager] mapShowGeofences];
//    _showLast5Locs = [[SettingsManager sharedManager] mapShowLast5Pts];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
//    if (_showLast5Locs) {
//        [self drawMapMarkers];
//    }
    
    if (_showGeo) {
        [self loadLandmarks];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.permissionMissingView isHidden]) {
        [self zoomInOnLastCoord];
    }
}

-(void) zoomInOnLastCoord{
    
    CLLocationCoordinate2D location;
    MKCoordinateRegion zoomRegion;
#if TARGET_IPHONE_SIMULATOR
    location = CLLocationCoordinate2DMake(51.5100946, -0.1367563);
    [self.mapView setCenterCoordinate:location animated:YES];
    zoomRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    [self.mapView setRegion:zoomRegion animated:YES];

//    self.coordinateLabel.text = [NSString stringWithFormat:@"%f, %f",location.latitude, location.longitude];
    return;
#endif
    
    location.latitude = self.mapView.userLocation.coordinate.latitude;
    location.longitude = self.mapView.userLocation.coordinate.longitude;
    
    [self.mapView setCenterCoordinate:location animated:YES];
    zoomRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    [self.mapView setRegion:zoomRegion animated:YES];
    
//    self.coordinateLabel.text = [NSString stringWithFormat:@"%f, %f",location.latitude, location.longitude];
//
}

//-(void) drawMapMarkers{
//    NSArray *locations = [SGSDK sensorUpdateHistory:10];
//
//    for (NSDictionary *d in locations) {
//        NSNumber *lan = d[@"lat"];
//        NSNumber *lon = d[@"lon"];
//        float laf = lan.floatValue;
//        float lof = lon.floatValue;
//
//        if (laf == 0.0 && lof == 0.0) {
//            continue;
//        }
//
//        MKPointAnnotation *p = [[MKPointAnnotation alloc] init];
//        p.coordinate = CLLocationCoordinate2DMake(laf, lof);
//        [self.mapView addAnnotation:p];
//    }
//}



-(void) drawLandmarks{
    
    if (self.useDummyData) {
        
        NSInteger count = 0;
        for (NSArray *g in self.landmarks) {
            NSArray *coordAr = self.landmarks[count];
            CLLocationCoordinate2D geofenceArray[coordAr.count];
            NSInteger ptCount = 0;
            for (NSArray *coordSet in g) {
                NSNumber *latNum = (NSNumber *)coordSet[0];
                NSNumber *lonNum = (NSNumber *)coordSet[1];
                geofenceArray[ptCount] = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
                ptCount++;
            }
            MKPolygon *poly = [MKPolygon polygonWithCoordinates:geofenceArray count:coordAr.count];
            [self.mapView addOverlay:poly];
            count++;
        }
        
    }else{
        
        for (ProjectLandmark *lm in self.landmarks) {
            if ([lm.geometryType isEqualToString:@"circle"]) {
                 MKCircle *c = [lm mkCircle];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mapView addOverlay:c];
                });
            }else if([lm.geometryType isEqualToString:@"envelope"]){
                MKPolygon *r = [lm mkMapRect];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mapView addOverlay:r];
                });
            }else if([lm.geometryType isEqualToString:@"polygon"]){
                MKPolygon *p = [lm mkPolygon];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mapView addOverlay:p];
                });
            }
        }
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        
        MKPolygon *polygon = (MKPolygon *)overlay;
        MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon];
        renderer.fillColor = [[UIColor alloc] initWithRed:1 green:0.63 blue:0.60 alpha:0.4];
        renderer.strokeColor = [UIColor redColor];
        renderer.lineWidth = 1;
        
        return renderer;
    } else if([overlay isKindOfClass:[MKCircle class]]){
        
        MKCircle *c = (MKCircle *)overlay;
        MKCircleRenderer *r = [[MKCircleRenderer alloc]initWithCircle:c];
        r.fillColor = [[UIColor alloc] initWithRed:1 green:0.63 blue:0.60 alpha:0.4];
        r.strokeColor = [UIColor redColor];
        r.lineWidth = 1;
        
        return r;
    }
    
    return nil;
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self.mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
//    self.coordinateLabel.text = [NSString stringWithFormat:@"%f, %f",view.annotation.coordinate.latitude, view.annotation.coordinate.longitude];
}


- (IBAction)mapSettingsTapped:(id)sender {
}

- (IBAction)chooseMapTapped:(id)sender {
}

- (IBAction)openDeviceSettings:(id)sender {
    NSURL* settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:settingsURL];
}

#pragma mark - Permission View

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.permissionMissingView setHidden:NO];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.permissionMissingView setHidden:YES];
            break;
        default:
            break;
    }
}

@end
