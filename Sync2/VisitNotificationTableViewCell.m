//
//  VisitNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "VisitNotificationTableViewCell.h"

@implementation VisitNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.mapView.delegate = self;
    [self.mapView setUserInteractionEnabled:NO];
}

- (void)configureCell {
    
    self.titleLabel.text = self.notification.title;
    self.detailLabel.text = self.notification.body;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(self.notification.timestamp / 1000.0)]]];
    
    self.address1Label.text = self.notification.addressTitle;
    self.address2Label.text = self.notification.address;
    
    self.notification.landmark
    
//    if ([lm.geometryType isEqualToString:@"circle"]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            GMSCircle *p = [lm googleMkCircle];
//            p.map = self.mapView;
//        });
//    }else if([lm.geometryType isEqualToString:@"rectangle"]){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            GMSPolygon *p = [lm googleMkRect];
//            p.map = self.mapView;
//        });
//    }else if([lm.geometryType isEqualToString:@"polygon"]){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            GMSPolygon *p = [lm googleMkPolygon];
//            p.map = self.mapView;
//        });
//    }
    
//    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(notification.latitude, notification.longitude);
//    [self.mapView setCenterCoordinate:location animated:YES];
//    MKCoordinateRegion zoomRegion = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
//    [self.mapView setRegion:zoomRegion animated:YES];
    
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = location;
//    [self.mapView addAnnotation:point];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
