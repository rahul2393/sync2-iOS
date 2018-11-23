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

- (instancetype)initWithApplicationId:(NSString *)applicationId accessKey:(NSString *)accessKey signatureKey:(NSString *)signatureKey buildingId:(NSInteger)buildingId;

@property (strong, nonatomic)  PWManagedLocationManager *phunwareManager;

@end
