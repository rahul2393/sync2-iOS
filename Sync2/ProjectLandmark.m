//
//  ProjectLandmark.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/30/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ProjectLandmark.h"

@implementation ProjectLandmark

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
        if (data[@"organizationId"]) {
            self.organizationId = data[@"organizationId"];
        }else{
            self.organizationId = @"";
        }
        if (data[@"updatedAt"]) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyyMMdd"];
            self.updatedAt = [dateFormat dateFromString:data[@"updatedAt"]];
        }
        
        if (data[@"createdAt"]) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyyMMdd"];
            self.createdAt = [dateFormat dateFromString:data[@"createdAt"]];
        }
        
        if (data[@"shape"]) {
            
            NSDictionary *model = data[@"shape"];
            self.geometryType = model[@"type"];
            
            NSArray *coordinate = model[@"coordinates"];
            
            if ([self.geometryType isEqualToString:@"circle"]) {
                
                NSMutableDictionary *centerDict = [[NSMutableDictionary alloc]initWithCapacity:2];
                [centerDict setValue:coordinate[0] forKey:@"lon"];
                [centerDict setValue:coordinate[1] forKey:@"lat"];
                
                self.center = centerDict;

                self.radius = model[@"radius"];
                
            } else if ([self.geometryType isEqualToString:@"envelope"]){
                
                NSArray *coordinate = model[@"coordinates"];
                NSMutableDictionary *seDict = [[NSMutableDictionary alloc]initWithCapacity:2];
                [seDict setValue:coordinate[0][0] forKey:@"lon"];
                [seDict setValue:coordinate[0][1] forKey:@"lat"];
                
                NSMutableDictionary *nwDict = [[NSMutableDictionary alloc]initWithCapacity:2];
                [nwDict setValue:coordinate[1][0] forKey:@"lon"];
                [nwDict setValue:coordinate[1][1] forKey:@"lat"];
                
                self.sePoint = seDict;
                self.nwPoint = nwDict;
                
            } else if ([self.geometryType isEqualToString:@"polygon"]){
                
                self.polyPts = coordinate.firstObject;
            }
        }
    }
    return self;
}

- (GMSPolygon *)googleMkPolygon {
    
    if (![self.geometryType isEqualToString:@"polygon"]) {
        return nil;
    }
    
    GMSMutablePath *rect = [GMSMutablePath path];
    for (NSArray *coordSet in self.polyPts) {
        NSNumber *latNum = (NSNumber *)coordSet[1];
        NSNumber *lonNum = (NSNumber *)coordSet[0];
        [rect addCoordinate:CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue)];
    }

    // Create the polygon, and assign it to the map.
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
    polygon.fillColor = [UIColor colorWithRed:1 green:0.63 blue:0.60 alpha:0.4];
    polygon.strokeColor = [UIColor redColor];
    polygon.strokeWidth = 1;
    return polygon;
}

-(MKPolygon *)mkPolygon{
    if (![self.geometryType isEqualToString:@"polygon"]) {
        return nil;
    }
    CLLocationCoordinate2D geofenceArray[self.polyPts.count];
    NSInteger ptCount = 0;
    for (NSArray *coordSet in self.polyPts) {
        NSNumber *latNum = (NSNumber *)coordSet[1];
        NSNumber *lonNum = (NSNumber *)coordSet[0];
        geofenceArray[ptCount] = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
        ptCount++;
    }
    MKPolygon *poly = [MKPolygon polygonWithCoordinates:geofenceArray count:self.polyPts.count];
    return poly;
}

- (GMSCircle *)googleMkCircle {
    NSNumber *latNum = (NSNumber *)_center[@"lat"];
    NSNumber *lonNum = (NSNumber *)_center[@"lon"];
    CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
    GMSCircle *circ = [GMSCircle circleWithPosition:circleCenter
                                             radius:self.radius.doubleValue];
    
    circ.fillColor = [UIColor colorWithRed:1 green:0.63 blue:0.60 alpha:0.4];
    circ.strokeColor = [UIColor redColor];
    circ.strokeWidth = 1;
    return circ;
}


-(MKCircle *)mkCircle{
    NSNumber *latNum = (NSNumber *)_center[@"lat"];
    NSNumber *lonNum = (NSNumber *)_center[@"lon"];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latNum.doubleValue, lonNum.doubleValue);
    return [MKCircle circleWithCenterCoordinate:coord radius:self.radius.doubleValue];
}

- (GMSPolygon *)googleMkRect {
    
    NSNumber *nwLatNum = (NSNumber *)self.nwPoint[@"lat"];
    NSNumber *nwLonNum = (NSNumber *)self.nwPoint[@"lon"];
    
    NSNumber *seLatNum = (NSNumber *)self.sePoint[@"lat"];
    NSNumber *seLonNum = (NSNumber *)self.sePoint[@"lon"];
    
    GMSMutablePath *rect = [GMSMutablePath path];
    
    [rect addCoordinate:CLLocationCoordinate2DMake(nwLatNum.doubleValue, nwLonNum.doubleValue)];
    [rect addCoordinate:CLLocationCoordinate2DMake(nwLatNum.doubleValue, seLonNum.doubleValue)];
    [rect addCoordinate:CLLocationCoordinate2DMake(seLatNum.doubleValue, seLonNum.doubleValue)];
    [rect addCoordinate:CLLocationCoordinate2DMake(seLatNum.doubleValue, nwLonNum.doubleValue)];
    
    // Create the polygon, and assign it to the map.
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
    polygon.fillColor = [UIColor colorWithRed:1 green:0.63 blue:0.60 alpha:0.4];
    polygon.strokeColor = [UIColor redColor];
    polygon.strokeWidth = 1;
    return polygon;
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
