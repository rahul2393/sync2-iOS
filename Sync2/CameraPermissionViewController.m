//
//  CameraPermissionViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/5/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "CameraPermissionViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface CameraPermissionViewController ()

@end

@implementation CameraPermissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestCameraPermissionsIfNeeded {
    
    // check camera authorization status
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized: { // camera authorized
            // do camera intensive stuff
            [self.parentPageViewController next];
        }
            break;
        case AVAuthorizationStatusNotDetermined: { // request authorization
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.parentPageViewController next];
                });
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.parentPageViewController next];
            });
        }
            break;
        default:
            break;
    }
}

- (IBAction)enableCameraTapped:(id)sender {
    
    [self requestCameraPermissionsIfNeeded];
    
    //[self.parentPageViewController next];
}

- (IBAction)skipTapped:(id)sender {
    
    [self.parentPageViewController next];
}
@end
