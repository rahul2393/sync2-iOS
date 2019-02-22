//
//  MapViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@import MapKit;
@import SixgillSDK;

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, SGAtlasDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *mapSettingsButton;
@property (weak, nonatomic) IBOutlet UIView *permissionMissingView;
@property (weak, nonatomic) IBOutlet UIView *chooseMapView;
    
- (IBAction)mapSettingsTapped:(id)sender;
- (IBAction)openDeviceSettings:(id)sender;
@end

@protocol MapViewDelegate

-(void) showWorldMap:(BOOL)yesOrNo;

@end
