//
//  AboutViewController.m
//  iMindU
//
//  Created by Sebastian Engel on 21.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

@synthesize email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    email.text = @"iMindU ist ein kleines Helferlein um schnell Erinnerungen in den Kalender des iPhones zu setzen. iMindU hat keinen eigenen, selbst verwalteten Kalender, sondern nutzt den normalen iOS-Kalender der Kalender-App. Das hat den Vorteil, dass die Erinnerungen, dank iCloud, auch zu anderen iOS-Geräten, Macs und Computern synchronisisiert wird.\n\nWeitere Informationen unter http://www.dreamapp.de/iMindU\n\nAnregungen und Fragen:\nTwitter:\t@Juuro\nE-Mail:\tmail@sebastian-engel.de\n\nSebastian Engel\nArgonnenstraße 6\n72108 Rottenburg\nGermany\n\nVersion 1.0";
    email.text = @"iMindU is a small helper tool for fast adding a iMindU to the iPhone calendar. iMindU doesn't use an own calender but rather the normal iOS calendar from the Calendar-App. This has the advantage that the iMindUs will be synchronized over iCloud to your other iOS-Devices, Macs and Computers.\n\nAdditional informations: http://www.dreamapp.de/iMindU\n\nSuggestions and Questions:\nTwitter:\t@Juuro\nE-Mail:\tmail@sebastian-engel.de\n\nSebastian Engel\nArgonnenstraße 6\n72108 Rottenburg\nGermany\n\nVersion 1.0";
    email.dataDetectorTypes = UIDataDetectorTypeLink;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
