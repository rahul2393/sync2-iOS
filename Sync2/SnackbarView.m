//
//  SnackbarView.m
//  Sync2
//
//  Created by Sanchit Mittal on 04/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SnackbarView.h"

@import TTGSnackbar;

@implementation SnackbarView

+(void)showSnackbar:(NSString *)messageText actionText:(NSString *)actionText actionHandler:(void (^)())onActionHandler{
    
    TTGSnackbar *snackbar =  [[TTGSnackbar alloc] initWithMessage:messageText duration:TTGSnackbarDurationForever];
    [snackbar setActionText:actionText];
    snackbar.actionTextColor = [UIColor redColor];
    
    [snackbar setActionBlock:^(TTGSnackbar *bar) {
        
        onActionHandler();
        
        [bar dismiss];
        
    }];
    [snackbar show];
}

@end
