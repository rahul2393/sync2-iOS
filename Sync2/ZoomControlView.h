//
//  ZoomControlView.h
//  Sync2
//
//  Created by Sanchit Mittal on 04/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExtension.h"
@import GoogleMaps;

@interface ZoomControlView : UIView
@property(nonatomic, strong) GMSMapView *mapView;
- (IBAction)zoomIn:(id)sender;
- (IBAction)zoomOut:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

