//
//  SGProviderDelegate.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 29/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#ifndef SGProviderDelegate_h
#define SGProviderDelegate_h

@protocol SGProviderDelegate

-(void) didEnterRegion:(NSString *)floorPlanId floorPlanName:(NSString *)name;

-(void) didExitRegion;

-(void)locationUpdates:(CGPoint)point size:(CGFloat)size;

@end


#endif /* SGProviderDelegate_h */
