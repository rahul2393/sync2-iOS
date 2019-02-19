//
//  VisitNotificationTableViewCell.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "VisitNotificationTableViewCell.h"
#import "ProjectLandmark.h"

@implementation VisitNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.mapView setUserInteractionEnabled:YES];
}

- (void)configureCell {
    
    self.titleLabel.text = self.notification.title;
    self.detailLabel.text = self.notification.body;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(self.notification.timestamp / 1000.0)]]];
    
    self.address1Label.text = self.notification.addressTitle;
    self.address2Label.text = self.notification.address;
    
//    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:currentEvent.locationsArray[0].latitude longitude: currentEvent.locationsArray[0].longitude];
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:10];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.mapView.camera = camera;
//    });
    
    
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:self.notification.landmark
                 options:0
                 error:&error];
    
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)object;
        ProjectLandmark *pl = [[ProjectLandmark alloc] initWithData:responseDict];
        
        if ([pl.geometryType isEqualToString:@"circle"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSCircle *p = [pl googleMkCircle];
                p.map = self.mapView;
            });
        }else if([pl.geometryType isEqualToString:@"envelope"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSPolygon *p = [pl googleMkRect];
                p.map = self.mapView;
            });
        }else if([pl.geometryType isEqualToString:@"polygon"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSPolygon *p = [pl googleMkPolygon];
                p.map = self.mapView;
            });
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
