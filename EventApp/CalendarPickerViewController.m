//
//  CalendarPickerViewController.m
//  Reminder
//
//  Created by Sebastian Engel on 09.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarPickerViewController.h"
#import <EventKit/EventKit.h>


@implementation CalendarPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        calendars = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}

- (void)dealloc
{    
    [ud release];
    ud = nil;
    [calendars release];
    calendars = nil;
    [value release];
    value = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    // Get the shared instance of NSUserDefaults
    ud = [NSUserDefaults standardUserDefaults];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)getCalendarTitles {
    
    calendars = [[NSMutableArray alloc] init];
    
    counter = 0;    
    eventDB = [[EKEventStore alloc] init]; 
    
    for (EKCalendar *thisCalendar in eventDB.calendars){
        if (thisCalendar.allowsContentModifications != NO){
            counter++;
            [calendars addObject:thisCalendar.title];
        }
    }
    
    [eventDB release];
    eventDB = nil;
    [self.tableView reloadData];
    [self.tableView setNeedsDisplay];
    // TODO: Kalenderliste wird aktualiesiert wenn View aktiv ist.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getCalendarTitles];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [calendars release];
    calendars = nil;
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
		case 0:
			return counter;
            
		default:
			return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
           
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [calendars objectAtIndex:indexPath.row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    value = [ud stringForKey:@"selectedCalendar"];
    
    NSLog(@"%@",value);
    
    for (NSInteger i=0; i<[tableView numberOfRowsInSection:0]; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        
        [tableView deselectRowAtIndexPath:ip animated:YES];
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:ip];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        oldCell.selectionStyle = UITableViewCellSelectionStyleBlue; 
    }
    
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    
    EKCalendar *thisCalendar = [calendars objectAtIndex:indexPath.row];
    NSLog(@"%@", thisCalendar);
    
    [ud setObject:thisCalendar forKey:@"selectedCalendar"];
    
    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    newCell.selectionStyle = UITableViewCellSelectionStyleNone;
    */
}

@end
