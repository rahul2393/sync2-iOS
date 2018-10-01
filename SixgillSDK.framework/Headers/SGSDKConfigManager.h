//
//  SGSDKConfigManager.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 7/24/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGSDKConfigManager : NSObject

@property(nonatomic, readwrite) BOOL shouldSendDataToServer;
@property(nonatomic, readwrite) NSString *ingressURL;

- (instancetype)initWithIngressURL:(NSString *)url andShouldSendDataToServer:(BOOL)shouldSendDataToServer;

@end
