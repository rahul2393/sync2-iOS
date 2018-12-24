//
//  CameraViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 24/12/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CameraViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIButton *captureButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

- (IBAction)captureImage:(UIButton *)sender;
- (IBAction)uploadImage:(UIButton *)sender;

@end
