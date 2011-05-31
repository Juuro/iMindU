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

+ (void)initialize
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *pListPath = [path stringByAppendingPathComponent:@"Settings.bundle/Root.plist"];
    
    NSDictionary *pList = [NSDictionary dictionaryWithContentsOfFile:pListPath];
	
    NSMutableArray *prefsArray = [pList objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *regDictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in prefsArray) {
        NSString *key = [dict objectForKey:@"Key"];
        if (key) {
            id value = [dict objectForKey:@"DefaultValue"];
            [regDictionary setObject:value forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:regDictionary];
}
@end
