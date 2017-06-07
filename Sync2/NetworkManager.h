//
//  NetworkManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkManagerInterface



@end

@interface NetworkManager : NSObject <NetworkManagerInterface>

+ (id)sharedManager;

@property (nonatomic, strong) id<NetworkManagerInterface> interface;

@end
