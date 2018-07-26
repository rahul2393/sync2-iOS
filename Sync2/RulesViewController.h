//
//  RulesViewController.h
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentControl.h"

@interface RulesViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet CustomSegmentControl *segmentView;

@end
