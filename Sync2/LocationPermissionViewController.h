//
//  LocationPermissionViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 5/30/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PermissionPageController.h"

@interface LocationPermissionViewController : UIViewController

@property (nonatomic, weak) PermissionPageController *parentPageViewController;

- (IBAction)enableLocationTapped:(id)sender;
- (IBAction)skipTapped:(id)sender;

@end
