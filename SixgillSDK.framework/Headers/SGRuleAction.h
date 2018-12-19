//
//  SGRuleAction.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 19/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGRuleAction : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *emails;

- (instancetype)initWithData:(NSDictionary *)data;

@end
