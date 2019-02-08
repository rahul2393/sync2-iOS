//
//  Organization.h
//  Sync2
//
//  Created by Sanchit Mittal on 30/01/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Organization : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *objectId;

- (instancetype)initWithData:(NSDictionary *)data;

-(NSDictionary *) toDictionary;


@end
