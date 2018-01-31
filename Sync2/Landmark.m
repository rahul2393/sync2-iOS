//
//  Landmark.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/30/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "Landmark.h"

@implementation Landmark

-(MKPolygon *)mkPolygon{
    if (![self.geometryType isEqualToString:@"polygon"]) {
        return nil;
    }
    CLLocationCoordinate2D geofenceArray[self.polyPts.count];
    NSInteger ptCount = 0;
    for (NSDictionary *coordSet in self.polyPts) {
        NSNumber *latNum = (NSNumber *)coordSet[@"lat"];
        NSNumber *lonNum = (NSNumber *)coordSet[@"lon"];
        geofenceArray[ptCount] = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
        ptCount++;
    }
    MKPolygon *poly = [MKPolygon polygonWithCoordinates:geofenceArray count:self.polyPts.count];
    return poly;
}

-(MKCircle *)mkCircle{
    NSNumber *latNum = (NSNumber *)_center[@"lat"];
    NSNumber *lonNum = (NSNumber *)_center[@"lon"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
    return [MKCircle circleWithCenterCoordinate:coord radius:self.radius.doubleValue];
}

-(MKPolygon *)mkMapRect{
    NSNumber *nwLatNum = (NSNumber *)self.nwPoint[@"lat"];
    NSNumber *nwLonNum = (NSNumber *)self.nwPoint[@"lon"];
    
    NSNumber *seLatNum = (NSNumber *)self.sePoint[@"lat"];
    NSNumber *seLonNum = (NSNumber *)self.sePoint[@"lon"];
    
    CLLocationCoordinate2D geofenceArray[4];
    
    geofenceArray[0] = CLLocationCoordinate2DMake(nwLatNum.doubleValue, nwLonNum.doubleValue);
    geofenceArray[1] = CLLocationCoordinate2DMake(nwLatNum.doubleValue, seLonNum.doubleValue);
    geofenceArray[2] = CLLocationCoordinate2DMake(seLatNum.doubleValue, seLonNum.doubleValue);
    geofenceArray[3] = CLLocationCoordinate2DMake(seLatNum.doubleValue, nwLonNum.doubleValue);
    
    MKPolygon *poly = [MKPolygon polygonWithCoordinates:geofenceArray count:4];
    return poly;
}

@end
