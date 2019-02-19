//
//  UIViewExtension.m
//  Sync2
//
//  Created by Sanchit Mittal on 23/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewExtension.h"

@implementation UIView (Test)


-(UIColor*) shadowColor {
    if(self.layer.shadowColor == nil) { return nil; }
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

-(void) setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

-(CGSize) shadowOffset {
    return self.layer.shadowOffset;
}

-(void) setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

-(CGFloat) shadowOpacity {
    return self.layer.shadowOpacity;
}

-(void) setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

-(CGFloat) shadowRadius {
    return self.layer.shadowRadius;
}

-(void) setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

-(UIColor*) borderColor {
    if(self.layer.borderColor == nil) { return nil; }
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void) setBorderColor:(UIColor *)borderColor {
    if (borderColor == nil) {
        self.layer.borderColor = nil;
    } else {
        self.layer.borderColor = borderColor.CGColor;
    }
}

-(CGFloat) borderWidth {
    return self.layer.borderWidth;
}

-(void) setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

-(CGFloat) cornerRadius {
    return self.layer.cornerRadius;
}

-(void) setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (UIViewController *)findViewController{
    
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}

@end
