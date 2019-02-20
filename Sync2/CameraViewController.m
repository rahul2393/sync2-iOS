//
//  CameraViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 24/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

@import SixgillSDK;

#import "CameraViewController.h"
#import "SettingsManager.h"
#import "SenseAPI.h"
#import "DataChannelSelectionViewController.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SGAtlasDelegate>
@property (nonatomic, readwrite) NSURL *imagePath;
@property (nonatomic, strong) NSArray *dataChannels;

@property (nonatomic, strong) UIImageView *providerMapImageView;
@property (nonatomic, strong) UIView *providerMapBlueDot;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hailer Integration";
    [self.progressView setHidden:YES];
    [self.activityIndicator setHidden:YES];
    
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
    
    [[SGSDK sharedInstance].providerManager setProviderDelegate:self];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[SGSDK sharedInstance].providerManager setProviderDelegate:nil];
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
    
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    NSMutableArray<void (^)(NSProgress *uploadProgress)>* uploadProgresses = [NSMutableArray new];
    NSMutableArray<NSURL *> *filePaths = [NSMutableArray new];
    
    [filePaths addObject:self.imagePath];
    [uploadProgresses addObject:^void(NSProgress *uploadProgress) {
        self.progressView.progress = uploadProgress.fractionCompleted;
    }];
    
    
    if (self.providerMapImageView) {
        NSFileManager *fileManager = NSFileManager.defaultManager;
        NSURL *documentPath = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        NSString *imageName = @"indoormap.jpg";
        NSURL *indoorImagePath = [documentPath URLByAppendingPathComponent:imageName];
        
        UIGraphicsBeginImageContextWithOptions(self.providerMapImageView.bounds.size, self.providerMapImageView.opaque, 0.0);
        [self.providerMapImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(img, 1.0f);
        [imageData writeToURL:indoorImagePath atomically:YES];
        
        [filePaths addObject:indoorImagePath];
        [uploadProgresses addObject:^void(NSProgress *uploadProgress) {
            
        }];
    }
    
    [SGSDK makehailerIncidentWithFilePaths:filePaths andCustomer:self.customerTextField.text andDescription:self.descriptionTextField.text andUploadProgressHandlers:uploadProgresses andSuccessHandler:^{
        
        [self.activityIndicator setHidden:YES];
        [self.activityIndicator stopAnimating];
        
        [self.progressView setHidden:YES];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Activity created successfully" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:true];
        }]];
        [self presentViewController:alertController animated:true completion:nil];
        
    } andFailureHandler:^(NSString *failureMsg) {
        [self.activityIndicator setHidden:YES];
        [self.activityIndicator stopAnimating];
        
        [self.progressView setHidden:YES];
        [self showAlertWithTitle:@"Error" andMessage:@"Try Again"];
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    NSFileManager *fileManager = NSFileManager.defaultManager;
    NSURL *documentPath = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSString *imageName = @"userImage.jpg";
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

- (void)didEnterRegionWithFloorMap:(IAFloorPlan *)floorplan andImage:(NSData *)imageData{
    float blueDotSize = 20;
    
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    self.providerMapImageView = [UIImageView new];
    self.providerMapImageView.image = image;
    [self.providerMapImageView sizeToFit];
    self.providerMapImageView.backgroundColor = [UIColor whiteColor];
    
    self.providerMapBlueDot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.0, 1.0)];
    self.providerMapBlueDot.backgroundColor =  [UIColor colorWithRed:0 green:0.3176 blue:0.7764 alpha:1];
    self.providerMapBlueDot.layer.cornerRadius = self.providerMapBlueDot.frame.size.width / 2;
    self.providerMapBlueDot.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.providerMapBlueDot.layer.borderWidth = 0.2;
    
    [self.providerMapImageView addSubview:self.providerMapBlueDot];
    self.providerMapBlueDot.center = self.providerMapImageView.center;
    self.providerMapBlueDot.transform = CGAffineTransformMakeScale(blueDotSize, blueDotSize);
}

- (void)didUpdateLocation:(IALocation *)location andPoint:(CGPoint)point{
    if (self.providerMapImageView) {
        self.providerMapBlueDot.center = point;
    }
}

- (void)didExitRegion{
    self.providerMapImageView = nil;
    self.providerMapBlueDot = nil;
}

@end
