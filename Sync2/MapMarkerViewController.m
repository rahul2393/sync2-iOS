//
//  MapMarkerViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 8/2/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "MapMarkerViewController.h"

#define googleMapsAPIKey @"AIzaSyCwPbq_Cj0Oshqay3LRjpz-XAnAnwBF1lE"

@import GoogleMaps;
@import SixgillSDK;

@implementation MapMarkerViewController

-(void)loadMap{
    
    NSArray *locations = [SGSDK sensorUpdateHistory:10];
    NSDictionary *lastLocation = locations.firstObject;
    NSNumber *latn = lastLocation[@"lat"];
    NSNumber *lonn = lastLocation[@"lon"];
    float latf = latn.floatValue;
    float lonf = lonn.floatValue;
    
    [GMSServices provideAPIKey:googleMapsAPIKey];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latf
                                                            longitude:lonf
                                                                 zoom:18];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    for (NSDictionary *d in locations) {
        NSNumber *lan = d[@"lat"];
        NSNumber *lon = d[@"lon"];
        float laf = lan.floatValue;
        float lof = lon.floatValue;
        
        if (laf == 0.0 && lof == 0.0) {
            break;
        }
        
        GMSMarker *m = [[GMSMarker alloc] init];
        m.position = CLLocationCoordinate2DMake(laf, lof);
        m.snippet = @"Hello World";
        m.appearAnimation = kGMSMarkerAnimationPop;
        m.map = mapView;
    }
    
    
    
    
    
    self.view = mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMap];
    
}

@end
