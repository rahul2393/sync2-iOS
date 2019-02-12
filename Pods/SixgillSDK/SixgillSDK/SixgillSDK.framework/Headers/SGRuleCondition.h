//
//  SGRuleCondition.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 19/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SGRuleCondition : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray<SGRuleCondition *> *items;

@property (nonatomic, strong) NSString *timezone;

@property (nonatomic, strong) NSArray *ids;

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *objectDescription;

// Landmark
@property (nonatomic, strong) NSString *trigger;

//Attributes
@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSString *operator;

@property (nonatomic, strong) NSDate *scheduleToDate;
@property (nonatomic, strong) NSDate *scheduleFromDate;

@property (nonatomic, strong) NSArray<NSNumber *> *weekDays;

@property (nonatomic, strong) NSNumber *scheduleToMinutes;
@property (nonatomic, strong) NSNumber *scheduleFromMinutes;

- (instancetype)initWithData:(NSDictionary *)data;


@end
