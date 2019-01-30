//
//  CameraViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

@import SixgillSDK;

#import <ULID/ULID.h>

#import "CameraViewController.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "DataChannelSelectionViewController.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, readwrite) NSURL *imagePath;
@property (nonatomic, strong) NSArray *dataChannels;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hailer Integration";
    [self.progressView setHidden:YES];
    
    [self hideEmptyView:NO];
    
    [self checkForCameraPermission];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![[SettingsManager sharedManager] selectedHailerChannel]) {
        [[SenseAPI sharedManager] GetDataChannelsWithCompletion:^(NSArray *dataChannels, NSError * _Nullable error) {
            self.dataChannels = dataChannels;
            
            dispatch_async(dispatch_get_main_queue(),^{
                [self performSegueWithIdentifier:@"showHailerChannelSelection" sender:self];
            });
            
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        DataChannelSelectionViewController *dcsvc = (DataChannelSelectionViewController *)nav.viewControllers[0];
        dcsvc.channels = self.dataChannels;
        dcsvc.shouldFilterHailerType = true;
}

#pragma mark - IBActions

- (IBAction)browseImageTapped:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)captureImageTapped:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)createActivityTapped:(UIButton *)sender {
    if (!self.imagePath) {
        [self showAlertWithTitle:@"Error" andMessage:@"Select an image first"];
        return;
    } else if ([self.customerTextField.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"Error" andMessage:@"Customer cannot be empty"];
        return;
    } else if ([self.descriptionTextField.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"Error" andMessage:@"Description cannot be empty"];
        return;
    }
    
    [self.progressView setHidden:NO];
    self.progressView.progress = 0;
    
    [SGSDK makehailerIncidentWithFilePath:self.imagePath andCustomer:self.customerTextField.text andDescription:self.descriptionTextField.text andUploadProgressHandler:^(NSProgress *uploadProgress) {
        self.progressView.progress = uploadProgress.fractionCompleted;
        if (uploadProgress.fractionCompleted == 1) {
            [self showAlertWithTitle:@"Success" andMessage:@"Image upload successful"];
        }
    } andSuccessHandler:^{
        [self.progressView setHidden:YES];
        [self dismissViewControllerAnimated:true completion:nil];
        [self showAlertWithTitle:@"Success" andMessage:@"Activity created successful"];
        
    } andFailureHandler:^(NSString *failureMsg) {
        [self.progressView setHidden:YES];
        [self showAlertWithTitle:@"Error" andMessage:@"Try Again"];
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSURL *documentPath = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [[ULID new] ulidString]];
    self.imagePath = [documentPath URLByAppendingPathComponent:imageName];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 1.0f);
    [imageData writeToURL:self.imagePath atomically:YES];
    self.imageView.image = chosenImage;
    
    [self hideEmptyView:YES];
    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self hideEmptyView:NO];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Util

-(void) hideEmptyView:(BOOL) yesOrNo{
    [self.emptyView setHidden:yesOrNo];
    [self.imageView setHidden:!yesOrNo];
}

-(void) checkForCameraPermission{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Device has no camera!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [self dismissViewControllerAnimated:true completion:nil];
                                    }];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

-(void) showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:true completion:nil];
}
@end
