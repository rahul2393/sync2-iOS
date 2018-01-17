//
//  SenseNetworkManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SenseNetworkManagerInterface

-(void) GetDataChannelsWithCompletion:(void ( ^ _Nullable )(NSDictionary * _Nullable dataChannelsData, NSError * _Nullable error))completed;
-(void) GetProjectsWithCompletion:(void ( ^ _Nullable )(NSDictionary * _Nullable projectsData, NSError * _Nullable error))completed;
-(void) LoginWithEmail:(NSString *_Nonnull)email andPassword:(NSString *_Nonnull)password
        withCompletion:(void ( ^ _Nullable )(NSDictionary * _Nullable accountData, NSError * _Nullable error))completed;

@end

@interface SenseNetworkManager : NSObject <SenseNetworkManagerInterface>

+ (id)sharedManager;

@property (nonatomic, strong) id<SenseNetworkManagerInterface> interface;

@end
