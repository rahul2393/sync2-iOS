//
//  LoginViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderViewController.h"
@interface LoginViewController : UIViewController <QRCodeReaderDelegate>

@property (weak, nonatomic) IBOutlet UIView *invalidLoginView;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *apiURLField;

- (IBAction)qrButtonTapped:(id)sender;

- (IBAction)loginButtonTapped:(id)sender;

- (IBAction)dismissInvalidLoginViewTapped:(id)sender;

- (IBAction)ForgotPasswordTapped:(id)sender;

@end
