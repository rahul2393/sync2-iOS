//
//  RuleCondition.h
//  Sync2
//
//  Created by Sanchit Mittal on 02/01/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuleCondition : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, readwrite) NSInteger indentationLevel;

@end
