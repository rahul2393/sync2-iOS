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

@property (nonatomic, readwrite) NSInteger selectedSegmentIndex;
- (void) updateView;
//- (void) buttonTapped: (UIButton*) button;
//buttonTapped(button: UIButton
@end

@implementation CustomSegmentControl

-(void) setCommaSeperatedButtonTitles:(NSString *)commaSeperatedButtonTitles {
    _commaSeperatedButtonTitles = commaSeperatedButtonTitles;
//    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}

- (void)setSelectorColor:(UIColor *)selectorColor {
    _selectorColor = selectorColor;
//    [self setNeedsLayout];
}

- (void)setSelectorTextColor:(UIColor *)selectorTextColor {
    _selectorTextColor = selectorTextColor;
//    [self setNeedsLayout];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _selectedSegmentIndex = 0;
        _buttonArray = [[NSMutableArray alloc] init];
        [self updateView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedSegmentIndex = 0;
        _buttonArray = [[NSMutableArray alloc] init];
        [self updateView];
    }
    return self;
}

-(void) updateView {
    [_buttonArray removeAllObjects];
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
    
    [self.buttonArray[0] setTitleColor:_selectorTextColor forState:normal];
    CGFloat selectorWidth = self.frame.size.width / buttonTitles.count;
    
    NSInteger y = (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame) - 3.0);
    
    self.selector = [[UIView alloc] initWithFrame:CGRectMake(0, y, selectorWidth, 3.0)];
    self.selector.backgroundColor = self.selectorColor;
    [self addSubview:_selector];
    
    // Create a StackView
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:_buttonArray];
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
    for (buttonIndex = 0; buttonIndex < [_buttonArray count]; buttonIndex++) {
        UIButton* btn = [_buttonArray objectAtIndex:buttonIndex];
        
        [btn setTitleColor:_textColor forState:normal];
        
        if (btn == button) {
            _selectedSegmentIndex = buttonIndex;
            CGFloat selectorStartPosition = self.frame.size.width / _buttonArray.count * buttonIndex;
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.selector.frame;
                frame.origin.x = selectorStartPosition;
                self.selector.frame = frame;
            }];
            
            [btn setTitleColor:_selectorTextColor forState:normal];
        }
    }
}

- (void)updateSegmentedControlSegs:(int)index {
    for(UIButton* btn in _buttonArray) {
        [btn setTitleColor:_textColor forState:normal];
    }
    
    CGFloat selectorStartPosition = self.frame.size.width / _buttonArray.count * index;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.selector.frame;
        frame.origin.x = selectorStartPosition;
        self.selector.frame = frame;

    }];
    
    [_buttonArray[index] setTitleColor:_selectorTextColor forState:normal];
}

@end
