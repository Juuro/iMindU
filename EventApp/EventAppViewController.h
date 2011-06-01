//
//  EventAppViewController.h
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@class SettingsViewController;

@interface EventAppViewController : UIViewController <UITextFieldDelegate> {
    UITextField *titleField;
    UITextField *timeField;
    UISegmentedControl *segment;
    UILabel *previewTitle;
    UILabel *previewDate;
    UIBarButtonItem *settingsButton;
    
    EKEventStore *eventDB;
    EKEvent *myEvent;
    EKAlarm *myAlarm;
    NSDate *dateTmp;
    
    NSNumberFormatter *formatter;
    
    SettingsViewController *settingsViewController;
}

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *timeField;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *settingsButton;
@property (nonatomic, retain) SettingsViewController *settingsViewController;

-(IBAction) newEvent;
-(IBAction) timeChange;
-(NSDate *) computeDate;
//-(BOOL)textFieldShouldReturn:(UITextField *)titleField;

-(IBAction) pushSettings:(id)sender;

@end
