//
//  Device.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"

@implementation UIDevice (Test)

@dynamic iPhone;
@dynamic iPad;
@dynamic width;
@dynamic height;
@dynamic maxLength;
@dynamic screenType;

- (Boolean)iPhone {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

- (Boolean)iPad {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

- (CGFloat)width {
    return UIScreen.mainScreen.bounds.size.width;
}

- (CGFloat)height {
    return UIScreen.mainScreen.bounds.size.height;
}

- (CGFloat)maxLength {
    return MAX(self.width, self.height);
}

- (ScreenType)screenType {
    if (self.iPhone  &&  self.maxLength < 568) {
        return iPhone4_4S;
    } else if (self.iPhone  &&  self.maxLength == 568) {
        return iPhones_5_5s_5c_SE;
    } else if (self.iPhone  &&  self.maxLength == 667) {
        return iPhones_6_6s_7_8;
    } else if (self.iPhone  &&  self.maxLength == 736) {
        return iPhones_6Plus_6sPlus_7Plus_8Plus;
    } else if (self.iPhone &&  self.maxLength == 812) {
        return iPhoneX;
    } else {
        return unknown;
    }
}

@end
