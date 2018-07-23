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
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.emailAddressField.delegate = self;
    self.passwordField.delegate = self;
    
    [self registerForKeyboardNotifications];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) attemptLogin{
    
    [[SettingsManager sharedManager] logout];
    
    //self.emailAddressField.text = @"rkirkendall@sixgill.com";
    //self.passwordField.text = @"rickyricky1";
    
    [self.emailAddressField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    [[SenseAPI sharedManager] LoginWithEmail:self.emailAddressField.text andPassword:self.passwordField.text withCompletion:^(NSError * _Nullable error) {
        if (![[SenseAPI sharedManager] userToken]) {
            dispatch_async(dispatch_get_main_queue(),^{
                [self.invalidLoginView setHidden:NO];
                self.passwordField.text = @"";
            });
        }else{
            // Login was good.
            dispatch_async(dispatch_get_main_queue(),^{
                [self performSegueWithIdentifier:@"showTabController" sender:self];
            });
        }
    }];
}

- (void)qrButtonActivated{
    
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:NO showTorchButton:NO];
    
    vc.delegate = self;
    
    // Set the presentation style
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:vc animated:YES completion:NULL];
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

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    // Show user feedback based on valid qr code or not
    
    
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)qrButtonTapped:(id)sender {
    //[self qrButtonActivated];
}

- (IBAction)loginButtonTapped:(id)sender {
    [self attemptLogin];
}

- (IBAction)dismissInvalidLoginViewTapped:(id)sender {
    
    [self.invalidLoginView setHidden: YES];
    
}

- (IBAction)ForgotPasswordTapped:(id)sender {
}
@end
