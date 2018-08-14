//
//  CopyLabel.m
//  Sync2
//
//  Created by Sanchit Mittal on 14/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CopyLabel.h"

@interface CopyLabel ()
-(void) commonInit;
@end

@implementation CopyLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setEnableCopy:(Boolean)enableCopy {
    _enableCopy = enableCopy;
    [self setUserInteractionEnabled:enableCopy];
}

- (void)commonInit {
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)]];
}

-(void) showMenu {
    [self becomeFirstResponder];
    
    UIMenuController *menu = UIMenuController.sharedMenuController;
    
    if (![menu isMenuVisible]) {
        [menu setTargetRect:self.bounds inView:self];
        [menu setMenuVisible:true animated:true];
    }
}

- (void)copy:(id)sender {
    UIPasteboard *board = UIPasteboard.generalPasteboard;
    board.string = self.text;
    
    UIMenuController *menu = UIMenuController.sharedMenuController;
    [menu setMenuVisible:false animated:true];
    
}

- (BOOL)canBecomeFirstResponder {
    return true;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:));
}

@end
