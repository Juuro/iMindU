//
//  SettingsViewController.m
//  Reminder
//
//  Created by Sebastian Engel on 27.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "CalendarPickerViewController.h"
#import "AlarmSignalPickerViewController.h"


@implementation SettingsViewController

@synthesize calendarPickerViewController;
@synthesize alarmsignalPickerViewController;

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self setTitle: @"Settings"];
        
        calendarPickerViewController = [[CalendarPickerViewController alloc] init];
        alarmsignalPickerViewController = [[AlarmSignalPickerViewController alloc] init];
    }
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)dealloc
{    
    [ud release];
    ud = nil;
    
    [datePickerSwitch release];
    datePickerSwitch = nil;
    
    [keyboardAtStartSwitch release];
    keyboardAtStartSwitch = nil;
    
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
    
    datePickerSwitch = [[UISwitch alloc] init];
    keyboardAtStartSwitch = [[UISwitch alloc] init];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self release];
    self = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
    value = [ud boolForKey:@"datePickerPrefKey"];
    if(value){
        [datePickerSwitch setOn:YES];
    }
    else {
        [datePickerSwitch setOn:NO];
    }
    
    value = [ud boolForKey:@"keyboardPrefKey"];    
    if(value){
        [keyboardAtStartSwitch setOn:YES];
    }
    else {
        [keyboardAtStartSwitch setOn:NO];
    }
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
		case 0:
			return 4;
            
		case 1:
			return 1;
            
		default:
			return 0;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Alarmsignal";
                cell.detailTextLabel.text = @"Ringelingeling";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;
            case 1:
                cell.textLabel.text = @"Calendar";
                
                eventDB = [[[EKEventStore alloc] init] autorelease];    
                EKCalendar *thisCalendar = [eventDB calendarWithIdentifier:[ud stringForKey:@"selectedCalendar"]];                
                cell.detailTextLabel.text = thisCalendar.title;
                eventDB = nil;
                [eventDB release];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                break;
            case 2:
                cell.textLabel.text = @"Datepicker";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                               
				[datePickerSwitch addTarget:self action:@selector(toggleDatePicker:) forControlEvents:UIControlEventValueChanged];
				cell.accessoryView = datePickerSwitch;
                break;
            case 3:
                cell.textLabel.text = @"Keyboard on launch";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
				[keyboardAtStartSwitch addTarget:self action:@selector(toggleKeyboardAtStart:) forControlEvents:UIControlEventValueChanged];
				cell.accessoryView = keyboardAtStartSwitch;
                break;
            default:
                break;
        }
    }
    else if(indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"About";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)toggleDatePicker:(UISwitch *)sender { 
    if(!datePickerSwitch.on){
        [ud setBool:NO forKey:@"datePickerPrefKey"];
    }
    else {
        [ud setBool:YES forKey:@"datePickerPrefKey"];
    }
}

- (void)toggleKeyboardAtStart:(UISwitch *)sender {
    if(!keyboardAtStartSwitch.on){
        [ud setBool:NO forKey:@"keyboardPrefKey"];
    }
    else {
        [ud setBool:YES forKey:@"keyboardPrefKey"];
    }
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
    
    if(indexPath.row == 0){
        [self.navigationController pushViewController:alarmsignalPickerViewController animated:YES];
        
    }
    else if(indexPath.row == 1){
        [self.navigationController pushViewController:calendarPickerViewController animated:YES];
    }
    else {
    
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
