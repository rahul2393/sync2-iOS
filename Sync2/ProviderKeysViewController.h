//
//  ProviderKeysViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 21/02/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProviderKeysViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UITextField *secretKeyTextField;

- (IBAction)submitTapped:(UIButton *)sender;

@end
