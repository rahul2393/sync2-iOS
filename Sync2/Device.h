//
//  Device.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#ifndef Device_h
#define Device_h


#endif /* Device_h */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScreenType) {
    iPhone4_4S = 1,
    iPhones_5_5s_5c_SE,
    iPhones_6_6s_7_8,
    iPhones_6Plus_6sPlus_7Plus_8Plus,
    iPhoneX,
    unknown
};

@interface UIDevice (Test)

@property (nonatomic) Boolean iPhone;
@property (nonatomic) Boolean iPad;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat maxLength;
@property (nonatomic, readwrite) ScreenType screenType;
@end;


