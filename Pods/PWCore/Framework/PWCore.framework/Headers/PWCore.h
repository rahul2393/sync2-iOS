//
//  PWCore.h
//  PWCore
//
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <PWCore/PWAnalytics.h>
#import <PWCore/PWCME.h>
#import <PWCore/PWLogger.h>
#import <PWCore/PWConsoleLogger.h>
#import <PWCore/PWFileLogger.h>
#import <PWCore/PWLoggableObject.h>
#import <PWCore/PWBundleManager.h>
#import <PWCore/PWAPIManager.h>
#import <PWCore/PWAPIRequestOperation.h>
#import <PWCore/PWAPIOperation.h>
#import <PWCore/PWCoreDevice.h>

static NSString * const PWCoreVersion = @"3.6.0";

/**
 `PWCore` implements core functionality used in all MaaS modules. All MaaS modules have a `PWCore` dependency.
 */

@interface PWCore : NSObject

///-----------------------
/// @name Required Methods
///-----------------------

/**
 Initializes PWCore and all associated MaaS modules. This method should be called inside `application:didFinishLaunchingWithOptions:` before you do anything else.
 @param applicationID You can find your Application ID in the MaaS portal.
 @param accessKey A unique key that identifies the client making the request. You can find your Access Key in the MaaS portal.
 @param signatureKey A unique key that is used to sign requests. The signature is used to both check request authorization as well as data integrity. You can find your Signature Key in the MaaS portal.
 */
+ (void)setApplicationID:(NSString *)applicationID
               accessKey:(NSString *)accessKey
            signatureKey:(NSString *)signatureKey;



/**
  This method has been deprecated. Use setApplicationID:accessKey:signatureKey: instead.
 @param applicationID You can find your Application ID in the MaaS portal.
 @param accessKey A unique key that identifies the client making the request. You can find your Access Key in the MaaS portal.
 @param signatureKey A unique key that is used to sign requests. The signature is used to both check request authorization as well as data integrity. You can find your Signature Key in the MaaS portal.
 @param encryptionKey A unique encryption key this is no longer required. set empty string.
 */
+ (void)setApplicationID:(NSString *)applicationID
			   accessKey:(NSString *)accessKey
			signatureKey:(NSString *)signatureKey
		   encryptionKey:(NSString *)encryptionKey __deprecated;

/**
 Returns the MaaS Application ID.
 */
+ (NSString *)applicationID;

/**
 Returns the Device ID.
 */
+ (NSString *)deviceID;

/**
 Returns 'PWCore'.
 */
+ (NSString *)serviceName;

/**
 This method registers the module and its version.
 @param moduleName The name of the dependent module to be registered.
 @param version version number for the module
 @param completion The completion block to be called.
 */
+ (void)registerModule:(NSString *)moduleName version:(NSString *)version withCompletion:(void(^)(NSError *error))completion;

/**
 Returns a dictionary of registered modules.
 */
+ (NSDictionary *)getAllRegisteredModules;

/**
 Returns version number for a registered module.
 @param moduleName The name of the dependent module to be registered.
 */
+ (NSString *)getVersionForModule:(NSString *)moduleName;

@end
