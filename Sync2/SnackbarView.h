//
//  SnackbarView.h
//  Sync2
//
//  Created by Sanchit Mittal on 04/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnackbarView : NSObject 

+(void)showSnackbar:(NSString *)messageText actionText:(NSString *)actionText actionHandler:(void (^)())onActionHandler;

@end
