//
//  SGAtlasDelegate.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 29/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

@import IndoorAtlas;

@protocol SGAtlasDelegate

-(void) didEnterRegionWithFloorMap:(IAFloorPlan *)floorplan andImage:(NSData *)imageData;

-(void) didExitRegion;

-(void) didUpdateLocation:(IALocation *)location andPoint:(CGPoint)point;

@end
