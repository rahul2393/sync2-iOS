//
//  Sync2UITests.m
//  Sync2UITests
//
//  Created by Ricky Kirkendall on 3/19/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Sync2UITests-Swift.h"
@interface Sync2UITests : XCTestCase

@end

@implementation Sync2UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    //[Snapshot setupSnapshot:app];
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [Snapshot setupSnapshot:app];
    [app launch];
    
    //[Snapshot snapshot:@"01LoginScreen" timeWaitingForIdle:0];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testTakeScreenshots {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    
    XCUIElement *acceptButton = [[XCUIApplication alloc] init].buttons[@"Accept"];
    [acceptButton tap];
    [acceptButton tap];
    
    
    [Snapshot snapshot:@"01StartingScreen" timeWaitingForIdle:10];
    [app.buttons[@"Continue"] tap];
    [app.buttons[@"Enable Location Services"] tap];
    [self addUIInterruptionMonitorWithDescription:@"Allow \u201cSync\u201d to access your location?" handler:^BOOL(XCUIElement * _Nonnull alert) {
        [alert.buttons[@"Always Allow"] tap];
        return YES;
    }];
    
    [app.buttons[@"Enable Motion and Activity"] tap];
    [self addUIInterruptionMonitorWithDescription:@"\u201cSync\u201d Would Like to Access Your Motion & Fitness Activity" handler:^BOOL(XCUIElement * _Nonnull alert) {
        [alert.buttons[@"OK"] tap];
        return YES;
    }];
    
    [app.buttons[@"Enable Push Notifications"] tap];
    [self addUIInterruptionMonitorWithDescription:@"\u201cSync\u201d Would Like to Send You Notifications" handler:^BOOL(XCUIElement * _Nonnull alert) {
        [alert.buttons[@"Allow"] tap];
        return YES;
    }];
    [app.buttons[@"Continue to Login"] tap];
    
    
    [app.buttons[@"Login with Sense Account"] tap];
    [Snapshot snapshot:@"02SenseLogin" timeWaitingForIdle:0];

    XCUIElementQuery *scrollViewsQuery = app.scrollViews;
    XCUIElement *textField = [scrollViewsQuery childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    [textField typeText:@"rkirkendall@sixgill.com"];
    
    XCUIElement *secureTextField = [scrollViewsQuery childrenMatchingType:XCUIElementTypeSecureTextField].element;
    [secureTextField tap];
    [secureTextField typeText:@"rickyricky1"];
    [app/*@START_MENU_TOKEN@*/.buttons[@"Login"]/*[[".scrollViews.buttons[@\"Login\"]",".buttons[@\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    
    XCUIElement *projecttableTable = app.tables[@"projectTable"];
    [projecttableTable/*@START_MENU_TOKEN@*/.staticTexts[@"My project"]/*[[".cells[@\"project cell\"].staticTexts[@\"My project\"]",".cells[@\"My project\"].staticTexts[@\"My project\"]",".staticTexts[@\"My project\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [projecttableTable.staticTexts[@"Select Project"] tap];
    
    
    XCUIElement *channeltableTable = app.tables[@"channelTable"];
    [channeltableTable/*@START_MENU_TOKEN@*/.staticTexts[@"ios channel"]/*[[".cells[@\"ios channel\"].staticTexts[@\"ios channel\"]",".staticTexts[@\"ios channel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [channeltableTable.staticTexts[@"Select Channel"] tap];
    
    [app.buttons[@"Button"] tap];
    [app.tables.switches[@"Display Project Landmarks"] tap];
    [app.navigationBars[@"Map Settings"].buttons[@"Map"] tap];
    [Snapshot snapshot:@"03MapView" timeWaitingForIdle:1];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    [tabBarsQuery.buttons[@"Notifications"] tap];
    [Snapshot snapshot:@"04Notifications" timeWaitingForIdle:1];
    [tabBarsQuery.buttons[@"Log"] tap];
    [Snapshot snapshot:@"05LogData" timeWaitingForIdle:0];
    
    
}

@end
