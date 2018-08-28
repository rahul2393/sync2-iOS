//
//  SurveyNotification.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNotification.h"


@interface SurveyOption: NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, readwrite) int optionId;

@end;

@interface SurveyNotification : BaseNotification

@property (nonatomic, strong) NSString *buttonText;
@property (nonatomic, strong) NSString *submitUrl;
@property (nonatomic, strong) NSArray* options;
@end
