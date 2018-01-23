//
//  DummySettingsData.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "DataChannel.h"
#import "Account.h"
@interface DummySettingsData : NSObject

+(Project *) project;
+(DataChannel *) dataChannel;
+(Account *) account;
+(NSString *) apiURL;

@end
