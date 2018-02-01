//
//  SettingsManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "Project.h"
#import "DataChannel.h"
@interface SettingsManager : NSObject

+ (id)sharedManager;

-(void) logout;


-(NSString *) currentAccountEmail;
-(void) setAccountEmail:(NSString *)email;

-(NSString *) selectedProjectId;
-(void) selectProject:(Project *)project;

-(NSString *) selectedDataChannelId;
-(void) selectDataChannel:(DataChannel *) dataChannel;

-(BOOL) mapShowLast5Pts;
-(BOOL) mapShowGeofences;
-(void) setMapShowLast5Pts:(BOOL)show;
-(void) setMapShowGeofences:(BOOL)show;

-(BOOL) hasOnboarded;

-(void) setHasOnboarded:(BOOL)hasOnboarded;


// Deprecated
-(void) addAccount:(Account *)account;

-(NSArray *) accounts;

-(NSString *)activeAccountId;
-(void) setActiveAccountId:(NSString *)accountId;

@end
