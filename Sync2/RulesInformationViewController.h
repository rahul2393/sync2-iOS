//
//  RulesInformationViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 30/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SixgillSDK;
#import "CustomSegmentControlViewController.h"

@interface RulesInformationViewController : CustomSegmentControlViewController

@property (strong, nonatomic) SGRule *rule;

@end
