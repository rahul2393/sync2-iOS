//
//  BaseNotification.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNotification : NSObject
@property (nonatomic, assign) NSInteger notificationId;
@property (nonatomic, assign) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, assign) int64_t timestamp;

- (instancetype)initWithPayload:(NSDictionary *)payload;
- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;
-(NSString *)displayableDate;

@end
