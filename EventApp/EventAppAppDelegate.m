//
//  EventAppAppDelegate.m
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAppAppDelegate.h"

#import "EventAppViewController.h"

@implementation EventAppAppDelegate


@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    
    self.window.rootViewController = self.viewController;
    
    eventAppViewController = [[EventAppViewController alloc] init];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:eventAppViewController];
    
    
    [eventAppViewController release];
    
    [window addSubview:navigationController.view];  
    
     
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Save data if appropriate.
}

- (void)dealloc {

    [window release];
    [viewController release];
    [super dealloc];
}

@end
