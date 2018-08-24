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
@property (nonatomic, strong) NSArray *environments;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailAddressField.delegate = self;
    self.passwordField.delegate = self;
    self.apiURLField.delegate = self;
    self.ingressAPIURLField.delegate = self;
    
    self.urlsDropdown.delegate = self;
    self.urlsDropdown.dataSource = self;
    
    self.checkBoxSelected = false;
    
    Environment *staging = [[Environment alloc] init];
    staging.name = @"Staging";
    staging.senseURL = @"http://sense-api-staging.sixgill.run";
    staging.ingressURL = @"http://sense-ingress-api-staging.sixgill.run";
    
    Environment *prod = [[Environment alloc] init];
    prod.name = @"Production";
    prod.senseURL = @"https://sense-api.sixgill.com";
    prod.ingressURL = @"https://sense-ingress-api.sixgill.com";
    
    Environment *dev = [[Environment alloc] init];
    dev.name = @"Production";
    dev.senseURL = @"https://sense-api-staging.dev.sixgill.io";
    dev.ingressURL = @"https://sense-ingress-api-staging.dev.sixgill.io";
    
    self.environments = @[staging, prod, dev];
    
//    self.emailAddressField.text = @"ritik.rishu@hotcocoasoftware.com";
//    self.passwordField.text = @"password123";
//    self.emailAddressField.text = @"cvalera@sixgill.com";
//    self.passwordField.text = @"super1234";
    
    self.selectedURLLabel.text = [[EnvironmentManager sharedManager] selectedEnvironment];
    
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
        self.scrollableViewHeightConstraint.constant = 839;
        self.URLDropdownHeight.constant = 0;
        [self.selectedURLLabel setHidden:YES];
    } else {
        self.viewHeightConstraint.constant = 0;
        self.URLDropdownHeight.constant = 44;
        self.scrollableViewHeightConstraint.constant = 675;
        [self.selectedURLLabel setHidden:NO];
    }
}


-(void) attemptLogin{
    
    [self.loginButton setHidden:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
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
                [self.loginButton setHidden:NO];
                [self.activityIndicator setHidden:YES];
                [self.activityIndicator stopAnimating];
            });
        }else{
            // Login was good.
            dispatch_async(dispatch_get_main_queue(),^{
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
}

- (IBAction)customURLButtonTapped:(id)sender {
    self.checkBoxSelected = !self.checkBoxSelected;
}

#pragma mark - MKDropdownMenu

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return self.environments.count;
}

- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Environment *env = self.environments[row];
    
    return env.senseURL;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Environment *env = self.environments[row];
    self.selectedURLLabel.text = env.senseURL;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
    });
    
    [SGSDK setIngressURL:env.ingressURL];
    [[EnvironmentManager sharedManager] setSelectedEnvironment:env.senseURL];
}

@end
