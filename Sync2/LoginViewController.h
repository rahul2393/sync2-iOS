//
//  LoginViewController.h
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderViewController.h"
@interface LoginViewController : UIViewController <QRCodeReaderDelegate>


- (IBAction)qrButtonTapped:(id)sender;


@end
