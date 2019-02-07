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
#import "WebViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, readwrite) BOOL checkBoxSelected;
@property (nonatomic, readwrite) NSString *forgotPasswordURL;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailAddressField.delegate = self;
    self.passwordField.delegate = self;
    self.phoneNumberField.delegate = self;
    
    self.urlsDropdown.delegate = self;
    self.urlsDropdown.dataSource = self;
    
    self.checkBoxSelected = false;
    
    self.emailAddressField.text = @"sanchit.mittal@hotcocoasoftware.com";
    self.passwordField.text = @"password123";
    self.phoneNumberField.text = @"1234";
    
    Environment *env = [[EnvironmentManager sharedManager] environments][0];
    self.selectedURLLabel.text = env.senseURL;
    self.forgotPasswordURL = env.forgotPasswordURL;
    [[EnvironmentManager sharedManager] setSelectedSenseURL:env.senseURL];
    [[EnvironmentManager sharedManager] setSelectedIngressURL:env.ingressURL];
    
    [self registerForKeyboardNotifications];
    
    [self.activityIndicator setHidden:YES];
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
        self.scrollableViewHeightConstraint.constant = 870;
        self.URLDropdownHeight.constant = 0;
        [self.selectedURLLabel setHidden:YES];
        self.apiURLField.delegate = self;
        self.ingressAPIURLField.delegate = self;
    } else {
        self.viewHeightConstraint.constant = 0;
        self.URLDropdownHeight.constant = 44;
        self.scrollableViewHeightConstraint.constant = 750;
        [self.selectedURLLabel setHidden:NO];
        self.apiURLField.delegate = nil;
        self.ingressAPIURLField.delegate = nil;
        
        Environment *env = [[EnvironmentManager sharedManager] environments][0];
        [[EnvironmentManager sharedManager] setSelectedSenseURL:env.senseURL];
        [[EnvironmentManager sharedManager] setSelectedIngressURL:env.ingressURL];
    }
}


-(void) attemptLogin{
    
    [self.loginButton setHidden:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    [[SettingsManager sharedManager] logout];
    
    [self.emailAddressField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.phoneNumberField resignFirstResponder];
    [self.apiURLField resignFirstResponder];
    [self.ingressAPIURLField resignFirstResponder];
    
    [self.invalidLoginView setHidden:YES];
    
    if (self.checkBoxSelected) {
        if (![self.ingressAPIURLField.text isEqualToString:@""]) {
            [[EnvironmentManager sharedManager] setSelectedIngressURL:self.ingressAPIURLField.text];
        }
        
        if (![self.apiURLField.text isEqualToString:@""]) {
            [[EnvironmentManager sharedManager] setSelectedSenseURL:self.apiURLField.text];
        }
    }
    
    
    [[SenseAPI sharedManager] LoginWithEmail:self.emailAddressField.text andPassword:self.passwordField.text withCompletion:^(NSError * _Nullable error) {
        if (![[SenseAPI sharedManager] userToken]) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.invalidLoginView setHidden:NO];
                self.passwordField.text = @"";
                [self.loginButton setHidden:NO];
                [self.activityIndicator setHidden:YES];
                [self.activityIndicator stopAnimating];
            });
        }else{
            // Login was good.
            dispatch_async(dispatch_get_main_queue(),^{
                
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:kPhoneNumber];
                [[NSUserDefaults standardUserDefaults] synchronize];

                [self performSegueWithIdentifier:@"showTabController" sender:self];
                [self.loginButton setHidden:NO];
                [self.activityIndicator setHidden:YES];
                [self.activityIndicator stopAnimating];
                
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
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.titleString = @"Forgot Password";
    webVC.urlString = self.forgotPasswordURL;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webVC];
    [navController.navigationBar setBarTintColor:[[UIColor alloc] initWithRed:2.0/255.0 green:44.0/255.0 blue:106.0/255.0 alpha:1]];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName , nil];
    navController.navigationBar.titleTextAttributes = attributes;
    
    [self presentViewController:navController animated:true completion:nil];

}

- (IBAction)customURLButtonTapped:(id)sender {
    self.checkBoxSelected = !self.checkBoxSelected;
}

#pragma mark - MKDropdownMenu

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return [[[EnvironmentManager sharedManager] environments] count];
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Environment *env = [[EnvironmentManager sharedManager] environments][row];
    
    return env.senseURL;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Environment *env = [[EnvironmentManager sharedManager] environments][row];
    self.selectedURLLabel.text = env.senseURL;
    self.forgotPasswordURL = env.forgotPasswordURL;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
    });
    
    [[EnvironmentManager sharedManager] setSelectedSenseURL:env.senseURL];
    [[EnvironmentManager sharedManager] setSelectedIngressURL:env.ingressURL];
}

@end
