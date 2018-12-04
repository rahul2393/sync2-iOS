//
//  SGAtlasProvider.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 26/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SGProviderManager.h"

#define SG_ATLAS_RESOURCE_ID @"SG_ATLAS_RESOURCE"

@import IndoorAtlas;

@interface SGAtlasProvider : SGProviderManager

- (instancetype)initWithApiKey:(NSString *)apiKey secretKey:(NSString *)secretKey;

@property (strong, nonatomic) IALocationManager *indoorManager;

@end

