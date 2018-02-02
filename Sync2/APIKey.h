//
//  APIKey.h
//  Sync2
//
//  Created by Ricky Kirkendall on 2/1/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIKey : NSObject

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *objectId;

-(NSDictionary *) toDictionary;

- (instancetype)initWithData:(NSDictionary *)apiDict;

@end
