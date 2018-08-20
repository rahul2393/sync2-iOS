//
//  LoginViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//


#import "SettingsManager.h"
#import "LoginViewController.h"
#import "SenseAPI.h"
#import "SDKManager.h"
#import "DataChannelSelectionViewController.h"
#import "ProjectSelectionViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, readwrite) BOOL checkBoxSelected;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailAddressField.delegate = self;
    self.passwordField.delegate = self;
    self.apiURLField.delegate = self;
    self.ingressAPIURLField.delegate = self;
    
    self.checkBoxSelected = false;
    
//    self.emailAddressField.text = @"ritik.rishu@hotcocoasoftware.com";
//    self.passwordField.text = @"password123";
//    self.emailAddressField.text = @"cvalera@sixgill.com";
//    self.passwordField.text = @"super1234";
    
    [self registerForKeyboardNotifications];
    
    [self.loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.enabled = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setCheckBoxSelected:(BOOL)checkBoxSelected {
    _checkBoxSelected = checkBoxSelected;
    
    UIImage * btnImage = checkBoxSelected ? [UIImage imageNamed: @"radio-button-check-blue"] : [UIImage imageNamed: @"checkbox-unselected"];
    [self.customURLButton setImage:btnImage forState:UIControlStateNormal];
    
    if (checkBoxSelected) {
        self.viewHeightConstraint.constant = 164;
        self.scrollableViewHeightConstraint.constant = 770;
    } else {
        self.viewHeightConstraint.constant = 0;
        self.scrollableViewHeightConstraint.constant = 606;
    }
}


-(void) attemptLogin{
    
    self.loginButton.enabled = NO;
    
    [[SettingsManager sharedManager] logout];
    
    [self.emailAddressField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.apiURLField resignFirstResponder];
    [self.ingressAPIURLField resignFirstResponder];
    
    if (self.checkBoxSelected) {
        if (![self.ingressAPIURLField.text isEqualToString:@""]) {
            [SGSDK setIngressURL:self.ingressAPIURLField.text];
        }
        
        if (![self.apiURLField.text isEqualToString:@""]) {
            [[EnvironmentManager sharedManager] setSelectedEnvironment:self.apiURLField.text];
        }
    }
    
    
    [[SenseAPI sharedManager] LoginWithEmail:self.emailAddressField.text andPassword:self.passwordField.text withCompletion:^(NSError * _Nullable error) {
        if (![[SenseAPI sharedManager] userToken]) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.invalidLoginView setHidden:NO];
                self.passwordField.text = @"";
                self.loginButton.enabled = YES;
            });
        }else{
            // Login was good.
            dispatch_async(dispatch_get_main_queue(),^{
                [self performSegueWithIdentifier:@"showTabController" sender:self];
                self.loginButton.enabled = YES;
            });
        }
    }];
}

#pragma mark - Keyboard handling

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // Scroll up so that the login button is visible
    CGPoint loginButtonBottom = CGPointMake(CGRectGetMinX(self.loginButton.frame), CGRectGetMaxY(self.loginButton.frame));

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;

    if (!CGRectContainsPoint(aRect, loginButtonBottom) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.loginButton.frame.origin.y - kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - IBAction

- (IBAction)loginButtonTapped:(id)sender {
    [self attemptLogin];
}

- (IBAction)dismissInvalidLoginViewTapped:(id)sender {
    
    [self.invalidLoginView setHidden: YES];
    
}

- (IBAction)ForgotPasswordTapped:(id)sender {
}

- (IBAction)customURLButtonTapped:(id)sender {
    self.checkBoxSelected = !self.checkBoxSelected;
}
@end
