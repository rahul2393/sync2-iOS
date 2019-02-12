//
//  SenseAPI.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/17/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGToken.h"
#import "EnvironmentManager.h"

@interface SenseAPI : NSObject

-(void) GetLandmarksWithCompletion:(void ( ^ _Nullable )(NSArray *landmarks, NSError * _Nullable error))completed;
-(void) GetDataChannelsWithCompletion:(void ( ^ _Nullable )(NSArray *dataChannels, NSError * _Nullable error))completed;
-(void) LoginWithEmail:(NSString *_Nonnull)email andPassword:(NSString *_Nonnull)password
        withCompletion:(void ( ^ _Nullable )(NSError * _Nullable error))completed;
-(void) GetOrganizationsWithCompletion:(void ( ^ _Nullable )(NSArray *orgs, NSError * _Nullable error))completed;
-(void) SetOrgId:(NSString *_Nonnull)orgId withCompletion:(void ( ^ _Nullable )(NSError * _Nullable error))completed;

-(void) GetAPIKeys:(BOOL)isChannelHailerType withCompletion:(void ( ^ _Nullable )(NSArray * apiKeys, NSError * _Nullable error))completed;

@property (nonatomic, strong) SGToken *userToken;
@property (nonatomic, strong) SGToken *userOrgToken;

+ (id)sharedManager;

+ (NSString *) serverAddress;


@end
