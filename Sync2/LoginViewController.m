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
#import "DataChannelSelectionViewController.h"
#import "ProjectSelectionViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) attemptLogin{
    
    [[SettingsManager sharedManager] logout];
    
    self.emailAddressField.text = @"rkirkendall@sixgill.com";
    self.passwordField.text = @"rickyricky1";
    
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
            [self performSegueWithIdentifier:@"showTabController" sender:self];
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
    [self qrButtonActivated];
}

- (IBAction)loginButtonTapped:(id)sender {
    [self attemptLogin];
}

- (IBAction)dismissInvalidLoginViewTapped:(id)sender {
    
    [self.invalidLoginView setHidden: YES];
    
}
@end
