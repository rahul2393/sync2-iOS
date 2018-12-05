//
//  SGIoTDevice.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 4/30/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGIoTDevice : NSObject

@property (nonatomic, strong) NSArray *sensors;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSString *channelAPIKey;

@end
