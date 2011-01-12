//
//  EventAppViewController.m
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventAppViewController.h"
#import <EventKit/EventKit.h>

@implementation EventAppViewController

@synthesize titleField;
@synthesize timeField;

-(IBAction) newEvent {
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    
    EKEvent *myEvent = [EKEvent eventWithEventStore:eventDB];
    
    EKAlarm *myAlarm = [EKAlarm alarmWithRelativeOffset:0];
    
    
    
    NSDate *dateTmp = [NSDate date];
    
    int myint = [timeField.text integerValue];  
    
    
    NSTimeInterval delta;
    if(segment.selectedSegmentIndex == 0){ 
        delta = 60  * myint;
    }
    else if (segment.selectedSegmentIndex == 1){
        delta = 60 * 60 * myint;
    }
    else {
        delta = 60 * 60 * 24 * myint;
    } 
    
    
    //NSTimeInterval delta = 60 * 60 * myint;
    dateTmp = [dateTmp dateByAddingTimeInterval:delta];
    
    
    
    
    
    myEvent.title = titleField.text;
    myEvent.startDate = dateTmp;
    myEvent.endDate = dateTmp;
    myEvent.alarms = [[NSArray alloc] initWithObjects: myAlarm, nil];
     
    
    
    
    
    [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
    
    NSError *err;
    
    [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err];
    
    
    if (err == noErr) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Event Created:"
                              message:titleField.text
                              delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    titleField.text = @"";
    timeField.text = @"";
    
    
    //[myEvent release];
    [eventDB release];
    
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [EKEvent release];
    [EKAlarm release];
    [titleField release];
    [timeField release];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
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
