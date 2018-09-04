//
//  SnackbarView.m
//  Sync2
//
//  Created by Sanchit Mittal on 04/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SnackbarView.h"

@implementation SnackbarView

- (MDCSnackbarMessage *)showSnackbar:(NSString *)messageText actionTitle:(NSString *)actionTitle actionHandler:(void (^)())onActionHandler {
    
    MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
    message.text = messageText;
    [message setDuration:10];
    
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];

    action.handler = onActionHandler;
    
    action.title = actionTitle;
    message.action = action;
    [MDCSnackbarManager showMessage:message];
    [MDCSnackbarManager setButtonTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    return message;
}
@end
