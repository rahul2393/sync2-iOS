//
//  LogMapViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogBaseViewController.h"
#import "LogMapDataViewController.h"
#import "ZoomControlView.h"

@import GoogleMaps;

@interface LogMapViewController : LogBaseViewController <LogMapDataDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *dateTimePickerLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *prevMapButton;
@property (weak, nonatomic) IBOutlet UIButton *nextMapButton;
@property (weak, nonatomic) IBOutlet UIView *noLogsView;
@property (weak, nonatomic) IBOutlet UIView *mapDisplayView;
@property (weak, nonatomic) IBOutlet UIView *mapDataView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet ZoomControlView *zoomControls;

- (IBAction)datePickerTapped:(id)sender;
- (IBAction)showPrevMap:(id)sender;
- (IBAction)showNextMap:(id)sender;

@end
