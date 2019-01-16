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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (nonatomic, readwrite) NSURL *imagePath;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.uploadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.title = @"Hailer Integration";
    [self.loadingView setHidden:YES];
    
    [self hideEmptyView:NO];
    
    [self checkForCameraPermission];
}

#pragma mark - IBActions

- (IBAction)captureImage:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];

}

- (IBAction)uploadImage:(UIButton *)sender {
    // TODO: Call SDK method to upload image
    if (self.imagePath) {
        
        [self.loadingView setHidden:NO];
        [self.loadingView startAnimating];
        
        [SGSDK uploadFileFromURL:self.imagePath andUploadProgressHandler:^(NSProgress *uploadProgress) {
            NSLog(@"Upload file progress is %f", uploadProgress.fractionCompleted);
        } andSuccessHandler:^{
            
            [self.loadingView setHidden:YES];
            [self.loadingView stopAnimating];
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                           message:@"Image upload successful"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];

        } andFailureHandler:^(NSString *failureMsg) {
            
            [self.loadingView setHidden:YES];
            [self.loadingView stopAnimating];
            
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
    [self.uploadButton setEnabled:yesOrNo];
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
