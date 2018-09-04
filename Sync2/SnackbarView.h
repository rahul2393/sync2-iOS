//
//  SnackbarView.h
//  Sync2
//
//  Created by Sanchit Mittal on 04/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "MaterialSnackbar.h"

@interface SnackbarView : NSObject 

- (MDCSnackbarMessage *)showSnackbar:(NSString *)messageText actionTitle:(NSString *)actionTitle actionHandler:(void (^)())onActionHandler;

@end
