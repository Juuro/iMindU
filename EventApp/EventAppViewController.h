//
//  EventAppViewController.h
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventAppViewController : UIViewController {
@private
    IBOutlet UITextField *titleField;
    IBOutlet UITextField *timeField;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UILabel *previewTitle;
    IBOutlet UILabel *previewDate;
}

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *timeField;

-(IBAction) newEvent;
-(IBAction) timeChange;
-(NSDate *) computeDate;

@end
