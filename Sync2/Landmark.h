//
//  Landmark.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/30/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@interface Landmark : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *type; // "geometry"
@property (nonatomic, strong) NSString *geometryType;

// Circle
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSDictionary *center; // center[@"lat"], [@"lon"]


// Rectangle
@property (nonatomic, strong) NSDictionary *nwPoint;
@property (nonatomic, strong) NSDictionary *sePoint;


// Polygon
@property (nonatomic, strong) NSArray *polyPts;



-(MKPolygon *)mkPolygon;

@end
