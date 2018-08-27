//
//  ActionNotification.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNotification.h"

@interface Action: NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, readwrite) int *actionId;
@property (nonatomic, strong) NSString *type;

@end;

@interface ActionNotification : BaseNotification

@property (nonatomic, strong) NSString *actionTitle;
@property (nonatomic, strong) NSString *submitUrl;
@property (nonatomic, strong) NSArray *actions;

@end
