//
//  HealthPermissionViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 10/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PermissionPageController.h"

@interface HealthPermissionViewController : UIViewController

@property (nonatomic, weak) PermissionPageController *parentPageViewController;

- (IBAction)enableHealthTapped:(id)sender;
- (IBAction)skipTapped:(id)sender;
@end
