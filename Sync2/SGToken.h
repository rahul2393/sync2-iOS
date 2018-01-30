//
//  SGToken.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGToken : NSObject

@property (nonatomic, strong) NSString *token;

- (instancetype)initWithData:(NSData *)data;

@end
