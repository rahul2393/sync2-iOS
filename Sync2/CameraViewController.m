//
//  CameraViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "CameraViewController.h"
@import SixgillSDK;
#import <ULID/ULID.h>

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, readwrite) NSURL *imagePath;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hailer Integration";
    [self.progressView setHidden:YES];
    
    [self hideEmptyView:NO];
    
    [self checkForCameraPermission];
}

#pragma mark - IBActions

- (IBAction)uploadImage:(UIButton *)sender {
    
    if (!self.imagePath) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    } else {
        // TODO: Call SDK method to upload image
        
        [self.progressView setHidden:NO];
        self.progressView.progress = 0;
        
        [SGSDK uploadFileFromURL:self.imagePath andUploadProgressHandler:^(NSProgress *uploadProgress) {
            self.progressView.progress = uploadProgress.fractionCompleted;
        } andSuccessHandler:^{
            
            [self.progressView setHidden:YES];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                           message:@"Image upload successful"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];

        } andFailureHandler:^(NSString *failureMsg) {
            
            [self.progressView setHidden:YES];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:@"Try again"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }
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
    if (yesOrNo) {
        [self.uploadButton setTitle:@"Capture Image" forState:UIControlStateNormal];
    } else {
        [self.uploadButton setTitle:@"Upload Image" forState:UIControlStateNormal];
    }
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

@end
