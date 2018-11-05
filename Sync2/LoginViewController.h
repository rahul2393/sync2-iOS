//
//  LoginViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKDropdownMenu.h"
@interface LoginViewController : UIViewController <MKDropdownMenuDataSource, MKDropdownMenuDelegate>

@property (weak, nonatomic) IBOutlet UIView *invalidLoginView;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *apiURLField;
@property (weak, nonatomic) IBOutlet UITextField *ingressAPIURLField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *customURLButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *urlsDropdown;
@property (weak, nonatomic) IBOutlet UILabel *selectedURLLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *URLDropdownHeight;

- (IBAction)loginButtonTapped:(id)sender;

- (IBAction)dismissInvalidLoginViewTapped:(id)sender;

- (IBAction)ForgotPasswordTapped:(id)sender;

- (IBAction)customURLButtonTapped:(id)sender;
@end
