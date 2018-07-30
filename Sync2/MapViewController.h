//
//  MapViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *mapSettingsButton;

- (IBAction)mapSettingsTapped:(id)sender;
- (IBAction)chooseMapTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *permissionMissingView;

@end
