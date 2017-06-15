//
//  MotionPermissionViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/5/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PermissionPageController.h"
#import <CoreMotion/CoreMotion.h>
@interface MotionPermissionViewController : UIViewController

@property (nonatomic, weak) PermissionPageController *parentPageViewController;
- (IBAction)enableMotionTapped:(id)sender;
- (IBAction)skipTapped:(id)sender;

@end
