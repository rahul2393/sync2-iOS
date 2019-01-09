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
@property (nonatomic, strong) NSArray *recipients;


@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *headers;

- (instancetype)initWithData:(NSDictionary *)data;

@end
