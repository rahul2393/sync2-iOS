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
#import "Landmark.h"
@import SixgillSDK;
@interface MapViewController ()

@property (nonatomic, strong) NSArray *coords;
@property (nonatomic, strong) NSArray *landmarks;

//@property (nonatomic, readwrite) BOOL showLast5Locs;
@property (nonatomic, readwrite) BOOL showGeo;
@property (nonatomic, readwrite) BOOL useDummyData;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *circle;
@property (nonatomic, strong) UIView *accuracyCircle;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IAFloorPlan *floorplan;
@property (nonatomic, strong) NSData *imageData;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.providerMapView setHidden:YES];
    
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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[SGSDK sharedInstance] providerManager].providerDelegate = nil;
}

- (void)didUpdateLocation:(CLLocation *)location {
    if (self.circle) {
        [UIView animateWithDuration:(self.circle.hidden ? 0.0f : 0.35f) animations:^{
            CGPoint point = [self.floorplan coordinateToPoint:location.coordinate];
            self.circle.center = point;
            self.accuracyCircle.center = point;
            
            CGFloat size = location.horizontalAccuracy * [self.floorplan meterToPixelConversion];
            
            self.accuracyCircle.transform = CGAffineTransformMakeScale(size, size);
            [self.view bringSubviewToFront:self.circle];
        }];
        self.accuracyCircle.hidden = NO;
        self.circle.hidden = NO;
    }
}

- (void)didEnterRegionWithFloorMap:(IAFloorPlan *)floorplan andImage:(NSData *)imageData {
    
    self.floorplan = floorplan;
    self.imageData = imageData;
    
    double width = floorplan.width;
    double height = floorplan.height;
    float size = floorplan.meterToPixelConversion;
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    float scale = fmin(1.0, fmin(self.providerMapView.bounds.size.width / width, self.providerMapView.bounds.size.height / height));
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    
    UIImageView *imageView = [UIImageView new];
    [self.providerMapView addSubview:imageView];
    imageView.frame = self.providerMapView.frame;
    
    imageView.transform = CGAffineTransformIdentity;
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, width, height);
    imageView.transform = t;
    imageView.center = self.providerMapView.center;
    imageView.backgroundColor = [UIColor whiteColor];
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    circle.backgroundColor = [UIColor colorWithRed:0.08627 green:0.5059 blue:0.9843 alpha:1.0];
    circle.layer.cornerRadius = circle.frame.size.width / 2;
    circle.layer.borderColor = [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] CGColor];
    circle.layer.borderWidth = 0.1;
    circle.hidden = YES;
    [imageView addSubview:circle];
    
    circle.transform = CGAffineTransformMakeScale(size, size);
    
    UIView *accuracyCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    accuracyCircle.backgroundColor = [UIColor colorWithRed:0.08627 green:0.5059 blue:0.9843 alpha:0.4];
    accuracyCircle.layer.cornerRadius = accuracyCircle.frame.size.width / 2;
    accuracyCircle.hidden = YES;
    [imageView addSubview:accuracyCircle];
    
    [self.mapView setHidden:YES];
    [self.providerMapView setHidden:NO];
    self.imageView = imageView;
    self.circle = circle;
    self.accuracyCircle = accuracyCircle;

}

- (void)didExitRegion {
    [self.providerMapView setHidden:YES];
    [self.mapView setHidden:NO];
}

- (void) loadLandmarks{
    Project *currentProject = [[SettingsManager sharedManager] selectedProject];
    if (!currentProject || !currentProject.objectId || [currentProject.objectId isEqualToString:@""]) {
        return;
    }
    [[SenseAPI sharedManager] GetLandmarksForProject:currentProject.objectId WithCompletion:^(NSArray *landmarks, NSError * _Nullable error) {
        self.landmarks = landmarks;
        
        [self drawLandmarks];
    }];        
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[SGSDK sharedInstance] providerManager].providerDelegate = self;
    
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
    [self zoomInOnLastCoord];
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
        
        for (Landmark *lm in self.landmarks) {
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
