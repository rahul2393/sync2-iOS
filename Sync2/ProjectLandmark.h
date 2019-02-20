//
//  ProjectLandmark.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/30/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@import GoogleMaps;
@interface ProjectLandmark : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *type; // "geometry"
@property (nonatomic, strong) NSString *geometryType;
@property (nonatomic, strong) NSString *organizationId;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSDate *createdAt;

// Circle
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, strong) NSDictionary *center; // center[@"lat"], [@"lon"]


// Rectangle
@property (nonatomic, strong) NSDictionary *nwPoint;
@property (nonatomic, strong) NSDictionary *sePoint;


// Polygon
@property (nonatomic, strong) NSArray *polyPts;



-(MKPolygon *)mkPolygon;
-(MKCircle *)mkCircle;
-(MKPolygon *)mkMapRect;

-(GMSPolygon *) googleMkPolygon;
-(GMSCircle *) googleMkCircle;
-(GMSPolygon *) googleMkRect;

- (instancetype)initWithData:(NSDictionary *)data;
- (instancetype)initWithNotificationData:(NSDictionary *)data;

@end
