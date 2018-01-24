//
//  TextNotification.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextNotification : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSDate *date;

-(NSString *)displayableDate;

@end
