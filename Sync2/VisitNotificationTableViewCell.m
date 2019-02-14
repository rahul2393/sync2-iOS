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

- (void)configureCell:(Notification *)notification {
    
    self.titleLabel.text = notification.title;
    self.detailLabel.text = notification.body;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(notification.timestamp / 1000.0)]]];
    
    self.address1Label.text = notification.addressTitle;
    self.address2Label.text = notification.address;
    
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
