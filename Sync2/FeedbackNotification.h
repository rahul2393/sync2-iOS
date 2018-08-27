//
//  FeedbackNotification.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNotification.h"

@interface FeedbackNotification : BaseNotification

@property (nonatomic, strong) NSString *commentHint;
@property (nonatomic, strong) NSString *buttonText;
@property (nonatomic, strong) NSString *submitUrl;

@end
