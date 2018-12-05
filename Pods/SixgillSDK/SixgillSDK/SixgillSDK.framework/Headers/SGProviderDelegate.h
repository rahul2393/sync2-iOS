//
//  SGProviderDelegate.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 29/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#ifndef SGProviderDelegate_h
#define SGProviderDelegate_h

@import IndoorAtlas;

@protocol SGProviderDelegate

-(void) didEnterRegionWithFloorMap:(IAFloorPlan *)floorplan andImage:(NSData *)imageData;

-(void) didExitRegion;

-(void)locationUpdates:(CGPoint)point;

@end


#endif /* SGProviderDelegate_h */
