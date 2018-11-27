//
//  WebViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@import WebKit;

@interface WebViewController : UIViewController

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *urlString;

@end
