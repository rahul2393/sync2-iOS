//
//  LogViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "SDKManager.h"
@interface LogViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
- (IBAction)actionButtonTapped:(id)sender;



@end
