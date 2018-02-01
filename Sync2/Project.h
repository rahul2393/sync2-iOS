//
//  Project.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, readwrite) BOOL enabled;

- (instancetype)initWithData:(NSDictionary *)data;

-(NSDictionary *) toDictionary;

@end
