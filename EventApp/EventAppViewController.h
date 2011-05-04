//
//  EventAppViewController.h
//  EventApp
//
//  Created by Sebastian Engel on 12.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventAppViewController : UIViewController <UITextFieldDelegate> {
    UITextField *titleField;
    UITextField *timeField;
    UISegmentedControl *segment;
    UILabel *previewTitle;
    UILabel *previewDate;
}

@property (nonatomic, retain) IBOutlet UITextField *titleField;
@property (nonatomic, retain) IBOutlet UITextField *timeField;

-(IBAction) newEvent;
-(IBAction) timeChange;
-(NSDate *) computeDate;
//-(BOOL)textFieldShouldReturn:(UITextField *)titleField;

@end
