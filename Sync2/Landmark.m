//
//  Landmark.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/30/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "Landmark.h"

@implementation Landmark

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        if (data[@"id"]) {
            self.objectId = data[@"id"];
        }
        else{
            self.objectId = @"";
        }
        if (data[@"name"]) {
            self.name = data[@"name"];
        }else{
            self.name = @"";
        }
        if (data[@"address"]) {
            self.address = data[@"address"];
        }else{
            self.address = @"";
        }
        if (data[@"projectId"]) {
            self.projectId = data[@"projectId"];
        }
        else{
            self.projectId = @"";
        }
        if (data[@"type"]) {
            self.type = data[@"type"];
        }else{
            self.type = @"";
        }
        
        if (data[@"model"]) {
            NSDictionary *model = data[@"model"];
            self.geometryType = model[@"type"];
            
            if ([self.geometryType isEqualToString:@"circle"]) {
                self.center = model[@"center"];
                self.radius = model[@"radius"];
            }else if ([self.geometryType isEqualToString:@"rectangle"]){
                self.sePoint = model[@"se"];
                self.nwPoint = model[@"nw"];
            }else if([self.geometryType isEqualToString:@"polygon"]){
                self.polyPts = model[@"points"];
            }
        }
    }
    return self;
}

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
