//
//  UITapGestureRecognizerExtension.m
//  Sync2
//
//  Created by Sanchit Mittal on 03/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITapGestureRecognizerExtension.h"

@implementation UITapGestureRecognizer (Test)

- (BOOL)didTapAttributedTextInLabel:(UILabel *)label inRange:(NSRange)targetRange {
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:label.attributedText];
    
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = label.lineBreakMode;
    textContainer.maximumNumberOfLines = label.numberOfLines;
    CGSize labelSize =  label.bounds.size;
    textContainer.size = labelSize;
    
    CGPoint locationOfTouchInLabel = [self locationInView:label];
    CGRect textBoundingBox = [layoutManager usedRectForTextContainer:textContainer];
    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x, locationOfTouchInLabel.y - textContainerOffset.y);
    NSUInteger indexOfCharacter = [layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    indexOfCharacter = indexOfCharacter - 20;
    return NSLocationInRange(indexOfCharacter, targetRange);
    
}

@end
