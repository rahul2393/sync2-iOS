//
//  CustomSegmentControlViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 31/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegmentControlViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, readwrite) NSArray *viewControllerIdentifiers;
@property (nonatomic, readwrite) NSInteger currentPage;
@property (nonatomic, readwrite) NSString* commaSeperatedButtonTitles;
@property (nonatomic, readwrite) UIColor* textColor;
@property (nonatomic, readwrite) UIColor* selectorColor;
@property (nonatomic, readwrite) UIColor* selectorTextColor;
@end
