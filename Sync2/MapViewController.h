//
//  MapViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *coordinateView;
@property (weak, nonatomic) IBOutlet UIButton *mapSettingsButton;
@property (weak, nonatomic) IBOutlet UILabel *coordinateLabel;


- (IBAction)mapSettingsTapped:(id)sender;

@end
