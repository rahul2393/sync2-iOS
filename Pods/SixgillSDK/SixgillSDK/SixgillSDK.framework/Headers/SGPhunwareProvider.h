//
//  SGPhunwareProvider.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 23/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SGProviderManager.h"

#define SG_PHUNWARE_RESOURCE_ID @"SG_PHUNWARE_RESOURCE"


@import PWCore;
@import PWLocation;

@interface SGPhunwareProvider : SGProviderManager

@property (strong, nonatomic)  PWManagedLocationManager *phunwareManager;

@property (strong, nonatomic) NSString *applicationId;

@property (strong, nonatomic) NSString *accessKey;

@property (strong, nonatomic) NSString *signatureKey;

@property (nonatomic, readwrite) NSInteger buildingId;

@end
