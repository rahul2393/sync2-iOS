//
//  Rule.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/24/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rule : NSObject


@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ruledescription;
@property (nonatomic, readwrite) BOOL enabled;
@property (nonatomic, strong) NSDictionary *logicalCondition;
@property (nonatomic, strong) NSArray *actions;

// logicalCondition
@property (nonatomic, strong) NSArray *logicalConditionAnd;

// logicalCondition and
//@property (nonatomic, strong) NSArray *logicalConditionAndsda;


// actions
@property (nonatomic, strong) NSString *actionId;
@property (nonatomic, strong) NSString *actionType;
@property (nonatomic, strong) NSString *actionsuccessfullyExecutedAt;
@property (nonatomic, strong) NSString *actiondeviceId;
@property (nonatomic, strong) NSString *actionsubject;
@property (nonatomic, strong) NSString *actionMessage;
@property (nonatomic, strong) NSString *actionURL;
@property (nonatomic, strong) NSString *actionMethod;
@property (nonatomic, strong) NSDictionary *actionRecipients;

// actions recipients
@property (nonatomic, strong) NSArray *actionRecipientsEmails;

@property (nonatomic, readwrite) BOOL isActive;

- (instancetype)initWithData:(NSDictionary *)data;

@end
