//
//  CameraViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "CameraViewController.h"
@import SixgillSDK;

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.uploadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.title = @"Hailer Integration";
    
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
//    [SGSDK uploadImageForHailer:self.imageView.image andSuccessHandler:^{
//        
//    } andFailureHandler:^(NSString *failureMsg) {
//        
//    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
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
