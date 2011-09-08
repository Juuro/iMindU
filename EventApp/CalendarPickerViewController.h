//
//  CalendarPickerViewController.h
//  Reminder
//
//  Created by Sebastian Engel on 09.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface CalendarPickerViewController : UITableViewController {
    EKEventStore *eventDB;
    NSUInteger counter;
    NSMutableArray *calendars;
    
    NSUserDefaults *ud;    
    NSString *value;
}

-(UIImage *)imageWithColor:(UIColor *)color;

@end
