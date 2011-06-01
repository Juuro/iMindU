//
//  SettingsViewController.h
//  Reminder
//
//  Created by Sebastian Engel on 27.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UITableViewController {
    
    UISwitch *keyboardAtStartSwitch;
    UISwitch *datePickerSwitch;
    
    NSUserDefaults *ud;
    
    BOOL value;
}

@end
