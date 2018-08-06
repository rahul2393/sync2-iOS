//
//  LogInformationViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 05/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface LogInformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *dateTImeLabel;
@property (weak, nonatomic) NSDictionary *event;
@end
