//
//  SetupInfoViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PermissionPageController.h"

@interface SetupInfoViewController : UIViewController
@property (nonatomic, weak) PermissionPageController *parentPageViewController;

- (IBAction)continueTapped:(id)sender;

@end
