//
//  LogMapViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface LogMapViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *dateTimePickerLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)viewSDKLogsTapped:(id)sender;

@end
