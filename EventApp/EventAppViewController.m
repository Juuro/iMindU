//
//  EventAppViewController.m
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAppViewController.h"
#import <EventKit/EventKit.h>
#import <Foundation/Foundation.h>
#import "SettingsViewController.h"

@implementation EventAppViewController

@synthesize titleField;
@synthesize timeField;
@synthesize settingsButton;
@synthesize settingsViewController;
@synthesize previewDate;
@synthesize previewTitle;
@synthesize segment;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        settingsViewController = [[SettingsViewController alloc] init];
        
        [self setTitle: @"Reminder"];
        
        //self.segment;
        
        //Configure rightBarButtonItem
        self.navigationItem.rightBarButtonItem = 
        [[[UIBarButtonItem alloc] 
          initWithTitle:@"Settings"
          style:UIBarButtonItemStyleBordered
          target:self
          action: @selector(pushSettings:)] 
         autorelease];
    }
    return self;
}

//Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    ud = [NSUserDefaults standardUserDefaults];
    
    value = [ud boolForKey:@"keyboardPrefKey"];    
    if(value){
        [titleField becomeFirstResponder];        
    }
    else {
        
    }
    
    // If no calendar is already set, set the defaultCalendarForNewEvents.
    if ([ud stringForKey:@"selectedCalendar"] == nil){
        eventDB = [[[EKEventStore alloc] init] autorelease];
        EKCalendar *defaultCalendar =  [eventDB defaultCalendarForNewEvents];
        [ud setObject:defaultCalendar.calendarIdentifier forKey:@"selectedCalendar"];
        eventDB = nil;
        [eventDB release];
    }
     
    [super viewDidLoad];
}

- (BOOL)textField:(UITextField *)thetextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text {
    if ([text length]>=1) {
        if (thetextField == timeField) {
            //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
            NSLocale *l_en = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
            //NSLocale *l_de = [[NSLocale alloc] initWithLocaleIdentifier: @"de_DE"];
            formatter = [[NSNumberFormatter alloc] init];
            [formatter setLocale: l_en];
            [l_en release];
            
            if([text isEqualToString:[formatter stringFromNumber:[formatter numberFromString: text]]]){
                return YES;
            }
            else {
                return NO;
            }        
        }
        else {
            return YES;
        }
    }
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == titleField) {
        [titleField resignFirstResponder];
        [timeField becomeFirstResponder];
    }    
    return YES;
}

-(IBAction)pushSettings:(id)sender {
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

-(IBAction) newEvent {    
    eventDB = [[[EKEventStore alloc] init] autorelease];
    myEvent = [EKEvent eventWithEventStore:eventDB];    
    myAlarm = [EKAlarm alarmWithRelativeOffset:0];    
    
    myEvent.title = titleField.text;
    myEvent.startDate = [self computeDate];
    myEvent.endDate = [self computeDate];
    myEvent.alarms = [[[NSArray alloc] initWithObjects: myAlarm, nil] autorelease];
     
    [myEvent setCalendar:[eventDB calendarWithIdentifier:[ud stringForKey:@"selectedCalendar"]]];
    
    NSError *err;
    
    [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];    
    
    if (err == noErr) {
        NSDateFormatter* formatterTime = [[[NSDateFormatter alloc] init] autorelease];
        NSDateFormatter* formatterDate = [[[NSDateFormatter alloc] init] autorelease];
        
        [formatterTime setDateFormat:@"HH:mm"];
        [formatterDate setDateFormat:@"dd.MM.yyyy"];
        
        NSString *alertTime = [formatterTime stringFromDate:[self computeDate]];
        NSString *alertDate = [formatterDate stringFromDate:[self computeDate]];
        
        NSString *alertText = [NSString stringWithFormat:@"%@\n%@ Uhr %@", titleField.text, alertTime, alertDate];
         
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@" Alarm hinzugefügt:"
                              message:alertText
                              delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    [titleField setText:@""];
    [timeField setText:@""];
    
    myEvent = nil;
    [myEvent release];
    eventDB = nil;
    [eventDB release];
}

- (IBAction) timeChange {    
    NSDateFormatter* formatterTime = [[[NSDateFormatter alloc] init] autorelease];
    NSDateFormatter* formatterDate = [[[NSDateFormatter alloc] init] autorelease];
        
    [formatterTime setDateFormat:@"HH:mm"];
    [formatterDate setDateFormat:@"dd.MM.yyyy"];
    
    NSString *alertTime = [formatterTime stringFromDate:[self computeDate]];
    NSString *alertDate = [formatterDate stringFromDate:[self computeDate]];
    
    NSString *titleText = [NSString stringWithFormat:@"%@", titleField.text];
    NSString *dateText = [NSString stringWithFormat:@"%@ Uhr %@", alertTime, alertDate];
        
    [previewTitle setText:titleText];
    [previewDate setText:dateText];
}

- (NSDate *) computeDate {
    int myint = [timeField.text integerValue];
    
    NSDate *dateTmp =[[[NSDate alloc] init] autorelease];
    
    NSTimeInterval delta;
    if(segment.selectedSegmentIndex == 0){ 
        //minutes
        delta = 60  * myint;
    }
    else if (segment.selectedSegmentIndex == 1){
        //hours
        delta = 60 * 60 * myint;
    }
    else {
        //days
        delta = 60 * 60 * 24 * myint;
    }
    
    dateTmp = [dateTmp dateByAddingTimeInterval:delta];    
    
    return dateTmp;
}

- (void)dealloc
{
    [myAlarm release];
    [myEvent release];
    [eventDB release];
    [formatter release];
    
    [titleField release];
    [timeField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidUnload
{       
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
