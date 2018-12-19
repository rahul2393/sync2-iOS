//
//  SGRule.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 12/12/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingress.pbobjc.h"
#import "SGRuleCondition.h"
#import "SGRuleAction.h"

@interface SGRule : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) NSString *organizationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSString *ruledescription;
@property (nonatomic, strong) NSArray<SGRuleAction *> *actions;
@property (nonatomic, strong) NSString *conditions;
@property (nonatomic, strong) NSArray<SGRuleCondition *> *conditionsObject;
@property (nonatomic, readwrite) int64_t createdAt;
@property (nonatomic, readwrite) int64_t updatedAt;
@property (nonatomic, strong) NSString *generator;
@property (nonatomic, readwrite) BOOL enabled;
@property (nonatomic, strong) NSArray *channelIds;

- (instancetype)initWithIngressRule:(Rule *)rule;

@end
