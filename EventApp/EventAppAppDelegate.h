//
//  EventAppAppDelegate.h
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventAppViewController;

@interface EventAppAppDelegate : NSObject <UIApplicationDelegate> {
@private
    
	IBOutlet UINavigationController *navigationController;
    
    EventAppViewController *eventAppViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet EventAppViewController *viewController;

+ (void)initialize;

@end
