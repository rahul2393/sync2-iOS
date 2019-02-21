//
//  ProviderKeysViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 21/02/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import "ProviderKeysViewController.h"

@import SixgillSDK;

#import "UIView+Toast.h"
#import "SettingsManager.h"

@interface ProviderKeysViewController () <UITextFieldDelegate>

@end

@implementation ProviderKeysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.apiKeyTextField.delegate = self;
    self.secretKeyTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    // Scroll up so that the submit button is visible
    CGPoint submitButtonBottom = CGPointMake(CGRectGetMinX(self.submitButton.frame), CGRectGetMaxY(self.submitButton.frame));
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    if (!CGRectContainsPoint(aRect, submitButtonBottom) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.submitButton.frame.origin.y - kbSize.height);
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

- (IBAction)submitTapped:(UIButton *)sender {
    [self.view endEditing:YES];
        
    if ([self.apiKeyTextField.text isEqualToString:@""]) {
        [self.view makeToast:@"Please Enter API key"];
        return;
    }
    if ([self.secretKeyTextField.text isEqualToString:@""]) {
        [self.view makeToast:@"Please Enter Secret key"];
        return;
    }
    
    [[SettingsManager sharedManager] setProviderAPIKey:self.apiKeyTextField.text];
    [[SettingsManager sharedManager] setProviderSecretKey:self.secretKeyTextField.text];
    
    SGAtlasProvider *atlasProvider = [[SGAtlasProvider alloc] initWithApiKey:self.apiKeyTextField.text secretKey:self.secretKeyTextField.text];
    [[SGSDK sharedInstance] setProviderManager:atlasProvider];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
