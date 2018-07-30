//
//  RulesInformationViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 30/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentControl.h"

@interface RulesInformationViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet CustomSegmentControl *segmentView;
@property (nonatomic, readwrite) NSInteger currentPage;

@end
