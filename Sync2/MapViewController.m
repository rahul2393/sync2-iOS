//
//  MapViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MapViewController.h"
#import "DummyMapData.h"
@interface MapViewController ()

@property (nonatomic, strong) NSArray *coords;
@property (nonatomic, strong) NSArray *geofences;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];
    
    if (!self.coords) {
        self.coords = [DummyMapData coords];
        self.mapView.delegate = self;
    }
    
    if(!self.geofences){
        self.geofences = [DummyMapData geofences];
    }
    
    self.title = @"Map";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self drawMapMarkers];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self zoomInOnLastCoord];
}

-(void) zoomInOnLastCoord{
    CLLocationCoordinate2D last = CLLocationCoordinate2DMake([(NSNumber *)self.coords.lastObject[0] floatValue], [(NSNumber *)self.coords.lastObject[1] floatValue]);
    [self.mapView setCenterCoordinate:last animated:YES];
    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(last, 1000, 1000);
    [self.mapView setRegion:zoomRegion animated:YES];
}

-(void) drawMapMarkers{
    for (NSArray *c in self.coords) {
        MKPointAnnotation *p = [[MKPointAnnotation alloc] init];
        p.coordinate = CLLocationCoordinate2DMake([(NSNumber *)c[0] floatValue], [(NSNumber *)c[1] floatValue]);        
        [self.mapView addAnnotation:p];
    }
}

-(void) drawGeofences {
    
    NSInteger count = 0;
    for (NSArray *g in self.geofences) {
        NSArray *coordAr = self.geofences[count];
        CLLocationCoordinate2D geofenceArray[coordAr.count];
        for (NSArray *coordSet in g) {
            NSNumber *latNum = (NSNumber *)coordSet[0];
            NSNumber *lonNum = (NSNumber *)coordSet[1];
            geofenceArray[count] = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
        }
        MKPolygon *poly = [MKPolygon polygonWithCoordinates:geofenceArray count:coordAr.count];
        [self.mapView addOverlay:poly];
        count++;
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if (![overlay isKindOfClass:[MKPolygon class]]) {
        return nil;
    }
    MKPolygon *polygon = (MKPolygon *)overlay;
    MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon];
    renderer.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
    return renderer;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self.mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
    self.coordinateLabel.text = [NSString stringWithFormat:@"%f, %f",view.annotation.coordinate.latitude, view.annotation.coordinate.longitude];
}


- (IBAction)mapSettingsTapped:(id)sender {
}
@end
