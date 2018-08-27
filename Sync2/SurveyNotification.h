//
//  SurveyNotification.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNotification.h"

@interface SurveyNotification : BaseNotification

@property (nonatomic, strong) NSString *buttonText;
@property (nonatomic, strong) NSString *submitUrl;
@property (nonatomic, strong) NSArray* options;
@end

//    "options": [{
//        "id" : 0,
//        "text" : "Black Coffee"
//    },
//    {
//        "id" : 1,
//        "text" : "Coldbrew Coffee"
//    }],
//
