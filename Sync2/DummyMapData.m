//
//  DummyMapData.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/19/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DummyMapData.h"
@import CoreLocation;
@implementation DummyMapData

+(NSArray *) coords{
    return @[@[@34.016798, @-118.501226],
             @[@34.017432, @-118.501559],
             @[@34.014839, @-118.500831],
             @[@34.014105, @-118.502806]];
}

+(NSArray *) geofences{
    
    NSMutableArray *bluffsPoly = [NSMutableArray array];
    [bluffsPoly addObject:@[@34.017323, @-118.501902]];
    [bluffsPoly addObject:@[@34.016847, @-118.502165]];
    [bluffsPoly addObject:@[@34.015655, @-118.500711]];
    [bluffsPoly addObject:@[@34.015677, @-118.500008]];
    
    
    return bluffsPoly;
}

@end
