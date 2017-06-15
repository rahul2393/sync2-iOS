//
//  SDKManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDKManager : NSObject

+ (id)sharedManager;


-(void) startSDKWithAPIKey:(NSString *)apiKey;
-(void) stopSDK;

@end
