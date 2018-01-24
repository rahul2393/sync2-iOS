//
//  Rule.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/24/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rule : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ruleDescription;
@property (nonatomic, readwrite) BOOL isActive;



@end
