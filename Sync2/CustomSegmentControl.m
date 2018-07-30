//
//  CustomSegmentControl.m
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSegmentControl.h"

@interface CustomSegmentControl ()
@property (nonatomic, readwrite) UIView* selector;
@property (nonatomic, readwrite) NSMutableArray *buttonArray;
- (void) updateView;
@end

@implementation CustomSegmentControl

-(void) setCommaSeperatedButtonTitles:(NSString *)commaSeperatedButtonTitles {
    _commaSeperatedButtonTitles = commaSeperatedButtonTitles;
    [self updateView];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self updateView];
}

- (void)setSelectorColor:(UIColor *)selectorColor {
    _selectorColor = selectorColor;
    [self updateView];
}

- (void)setSelectorTextColor:(UIColor *)selectorTextColor {
    _selectorTextColor = selectorTextColor;
    [self updateView];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedSegmentIndex = selectedSegmentIndex;
    [self updateView];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.buttonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) updateView {
    [self.buttonArray removeAllObjects];
    for (UIView* view in self.subviews) {
        [view removeFromSuperview];
    }

    NSArray* buttonTitles = [self.commaSeperatedButtonTitles componentsSeparatedByString:@","];
    
    for (NSString* buttonTitle in  buttonTitles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:buttonTitle forState:normal];
        [button setTitleColor:self.textColor forState:normal];
        [button addTarget:self action: @selector(buttonTapped:) forControlEvents: UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }
    
    if (!(self.buttonArray.count > 0 )) {
        return ;
    }
    
    
    [self.buttonArray[self.selectedSegmentIndex] setTitleColor:self.selectorTextColor forState:normal];
    CGFloat selectorWidth = UIScreen.mainScreen.bounds.size.width / buttonTitles.count;
    
    NSInteger y = (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame) - 3.0);
    
    self.selector = [[UIView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width / self.buttonArray.count * self.selectedSegmentIndex, y, selectorWidth, 3.0)];
    self.selector.backgroundColor = self.selectorColor;
    [self addSubview:self.selector];
    
    // Create a StackView
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:self.buttonArray];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:stackView];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    
    [stackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
    [stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
    [stackView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = true;
    [stackView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = true;
    
}

- (void)buttonTapped:(UIButton *)button {
    
    int buttonIndex;
    for (buttonIndex = 0; buttonIndex < [self.buttonArray count]; buttonIndex++) {
        UIButton* btn = [self.buttonArray objectAtIndex:buttonIndex];
        
        [btn setTitleColor:self.textColor forState:normal];
        
        if (btn == button) {
            self.selectedSegmentIndex = buttonIndex;
            CGFloat selectorStartPosition = UIScreen.mainScreen.bounds.size.width / self.buttonArray.count * buttonIndex;
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.selector.frame;
                frame.origin.x = selectorStartPosition;
                self.selector.frame = frame;
            }];
            
            [btn setTitleColor:self.selectorTextColor forState:normal];
        }
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)updateSegmentedControlSegs:(NSInteger)index {
    for(UIButton* btn in self.buttonArray) {
        [btn setTitleColor:self.textColor forState:normal];
    }
    
    CGFloat selectorStartPosition = UIScreen.mainScreen.bounds.size.width / self.buttonArray.count * index;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.selector.frame;
        frame.origin.x = selectorStartPosition;
        self.selector.frame = frame;

    }];
    
    [self.buttonArray[index] setTitleColor:self.selectorTextColor forState:normal];
}

@end
