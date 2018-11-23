//
//  PWCore+Internal.h
//  PWCore
//
//  Created by Patrick Dunshee on 5/10/18.
//  Copyright © 2018 Phunware. All rights reserved.
//

#import <PWCore/PWCore.h>

typedef NS_ENUM(NSInteger, PWEnvironment) {
    PWEnvironmentProd,
    PWEnvironmentStage,
    PWEnvironmentDev
};

@interface PWCore (Internal)

+ (NSString *__nonnull)sessionID;

#pragma mark - Environment

+ (PWEnvironment)getEnvironment;

+ (void)setEnvironment:(PWEnvironment)environment;

+ (NSString *__nullable)accessKey;

+ (NSString *_Nullable)server;

+ (NSString *__nonnull)authorizationHeaderWithRequestBody:(NSData *__nonnull)requestBody httpMethod:(NSString *__nonnull)httpMethod;

+ (NSMutableURLRequest *__nonnull)buildRequestWithRequest:(NSMutableURLRequest *__nonnull)request;

+ (NSMutableDictionary *__nonnull)standardAnalyticsPayload;

#pragma mark - Analytics

+ (void)sendInternalAnalyticsPayload:(NSDictionary *__nonnull)payload completion:(void (^__nullable)(NSError *__nullable error))completion;

// Send analytics with Extra payload
+ (void)sendExtraAnalyticsPayload:(NSDictionary *__nonnull)payload completion:(void (^__nullable)(NSError *__nullable error))completion;

#pragma mark - Modules

+ (void)registerModule:(NSString *__nonnull)moduleName;

+ (void)registerPhunwareModule:(NSString *__nonnull)moduleName version:(NSString *__nonnull)version withCompletion:(void (^__nullable)(NSError *__nullable error))completion;

#pragma mark - Encryption

+ (NSData *_Nullable)encryptData:(NSData *__nonnull)data withKey:(NSString *__nonnull)key;

+ (NSData *_Nullable)decryptData:(NSData *__nonnull)data withKey:(NSString *__nonnull)key;

@end
