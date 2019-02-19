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
}

- (void)configureCell {
    
    [self.mapView setUserInteractionEnabled:YES];
    
    self.titleLabel.text = self.notification.title;
    self.detailLabel.text = self.notification.body;
    
    [self.mapView clear];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(self.notification.timestamp / 1000.0)]]];
    
    self.address1Label.text = self.notification.addressTitle;
    self.address2Label.text = self.notification.address;
    
    NSError *error = nil;
    id landmark = [NSJSONSerialization
                 JSONObjectWithData:self.notification.landmark
                 options:0
                 error:&error];
    

    __block CLLocationCoordinate2D currentLocation = CLLocationCoordinate2DMake(0, 0);
    
    if ([landmark isKindOfClass:[NSDictionary class]]) {
        NSDictionary *landmarkDict = (NSDictionary *)landmark;
        ProjectLandmark *pl = [[ProjectLandmark alloc] initWithNotificationData:landmarkDict];
        
        if ([pl.geometryType isEqualToString:@"circle"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSCircle *c = [pl googleMkCircle];
                
                NSNumber *latNum = (NSNumber *)pl.center[@"lat"];
                NSNumber *lonNum = (NSNumber *)pl.center[@"lon"];
                currentLocation = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
                
                c.map = self.mapView;
            });
        }else if([pl.geometryType isEqualToString:@"envelope"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSPolygon *e = [pl googleMkRect];
                
                NSNumber *nwLatNum = (NSNumber *)pl.nwPoint[@"lat"];
                NSNumber *nwLonNum = (NSNumber *)pl.nwPoint[@"lon"];
                
                currentLocation = CLLocationCoordinate2DMake(nwLatNum.doubleValue, nwLonNum.doubleValue);
                
                e.map = self.mapView;
            });
        }else if([pl.geometryType isEqualToString:@"polygon"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                GMSPolygon *p = [pl googleMkPolygon];
                
                NSNumber *latNum = (NSNumber *)pl.polyPts[0][1];
                NSNumber *lonNum = (NSNumber *)pl.polyPts[0][0];
                
                currentLocation = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
                
                p.map = self.mapView;
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation zoom:10];
            self.mapView.camera = camera;
        });
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
