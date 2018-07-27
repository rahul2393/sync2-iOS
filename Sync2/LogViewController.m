    //
//  LogViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "LogViewController.h"
#import "LogMapViewController.h"
#import "LogListViewController.h"

@interface LogViewController ()
@property (nonatomic, strong) NSString *logs;
@property (nonatomic,strong) UIPageViewController* pageController;
@property (nonatomic, readwrite) NSMutableArray *viewControllers;
@property (nonatomic, readwrite) NSInteger currentPage;
@property (nonatomic, readwrite) LogMapViewController* vc1;
@property (nonatomic, readwrite) LogListViewController* vc2;
-(void) createPageViewController;
-(NSUInteger) indexofviewController: (UIViewController*) viewController;
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = [[NSMutableArray alloc] init];
    self.logs = [[SDKManager sharedManager] logs];
    
    self.vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"LogMapViewControllerIdentifier"];
    self.vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"LogListViewControllerIdentifier"];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.segmentView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0.16 blue:0.4 alpha:1];
    [self.segmentView addTarget:self action:@selector(onChangeOfSegment:) forControlEvents:UIControlEventValueChanged];
    
    self.currentPage = 0;
    [self createPageViewController];
    
    
    [self.viewControllers addObject:self.vc1];
    [self.viewControllers addObject:self.vc2];
}

- (void)createPageViewController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.view.backgroundColor = [UIColor clearColor];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    
    for(UIScrollView *svScroll in self.pageController.view.subviews) {
        svScroll.delegate = self;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageController.view.frame = CGRectMake(0, CGRectGetMaxY(self.segmentView.frame), UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    });
    
    [self.pageController setViewControllers:[[NSArray alloc] initWithObjects:self.vc1, nil]  direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
}

- (NSUInteger)indexofviewController:(UIViewController *)viewController {
    if ([self.viewControllers containsObject:viewController]) {
        return [self.viewControllers indexOfObject:viewController];
    }
    return -1;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self indexofviewController:viewController];
    
    if (index != -1) {
        index = index - 1;
    }
    
    if (index < 0) {
        return nil;
    } else {
        return self.viewControllers[index];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self indexofviewController:viewController];
    
    if (index != -1) {
        index = index + 1;
    }
    
    if (index >= self.viewControllers.count) {
        return nil;
    } else {
        return self.viewControllers[index];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if(completed) {
        self.currentPage = [self.viewControllers indexOfObject:pageViewController.viewControllers.lastObject];
        [self.segmentView updateSegmentedControlSegs:self.currentPage];
    }
}

-(void) onChangeOfSegment:(CustomSegmentControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0: {
            [self.pageController setViewControllers:[[NSArray alloc] initWithObjects:self.viewControllers[0], nil]  direction:UIPageViewControllerNavigationDirectionReverse animated:true completion:nil];
            self.currentPage = 0;
            break;
        }
        case 1: {
            [self.pageController setViewControllers:[[NSArray alloc] initWithObjects:self.viewControllers[1], nil]  direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
            self.currentPage = 1;
            break;
        }
        default:
            break;
    }
}

@end
