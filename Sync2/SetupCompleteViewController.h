//
//  SetupCompleteViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 13/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PermissionPageController.h"

@interface SetupCompleteViewController : UIViewController
@property (nonatomic, weak) PermissionPageController *parentPageViewController;

- (IBAction)continueTapped:(id)sender;


@end
