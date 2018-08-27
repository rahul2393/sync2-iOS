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

- (instancetype)initWithPayload:(NSDictionary *)payload;

-(NSString *)displayableDate;

@end
//{
//    "actionTitle": "Let us know if you are attending.",
//    "actions" : [{
//        "text" : "Can't make it",
//        "actionId" : 786,
//        "type" : "secondary"
//    },
//                 {
//                     "text" : "Yes, attending",
//                     "actionId" : 007,
//                     "type" : "primary"
//                 }],
//    "submitUrl" : "https://api.sixgill.com/submitAction",
//}
//{
//    "commentHint" : "e.g. Needs another whiteboard",
//    "buttonText" : "Send Feedback",
//    "submitUrl" : "https://api.sixgill.com/sendFeedback",
//}
//{
//    "buttonText" : "Send",
//    "submitUrl" : "https://api.sixgill.com/submitSurvey",
//    "options": [{
//        "id" : 0,
//        "text" : "Black Coffee"
//    },
//                {
//                    "id" : 1,
//                    "text" : "Coldbrew Coffee"
//                },
//                {
//                    "id" : 2,
//                    "text" : "Espresso Coffee"
//                },
//                {
//                    "id" : 3,
//                    "text" : "Latte"
//                }],
//}
//{
//    "buttonText" : "Schedule",
//    "submitUrl" : "https://api.sixgill.com/schedule",
//    "startTimeStamp" : 1533889271,
//    "endTimeStamp": 1533999271,
//}
//{
//    "addressTitle": "WeWork Santa Monica",
//    "address": "520 Broadway, Santa Monica, CA 90401",
//    "latitude" : 34.0161307,
//    "longitude": -118.4939754,
//}
