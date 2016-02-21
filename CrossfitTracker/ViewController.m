//
//  ViewController.m
//  CrossfitTracker
//
//  Created by Katie Farquhar on 2/20/16.
//  Copyright © 2016 Katie Berner. All rights reserved.
//

#import "ViewController.h"
#import <EventKitUI/EventKitUI.h>

@interface ViewController ()
// The database with calendar events and reminders
@property (strong, nonatomic) EKEventStore *eventStore;

// Indicates whether app has access to event store
//@property (nonatomic) BOOL isAccessToEventStoreGranted;

@end

@implementation ViewController

@synthesize wodType;
@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.introLabel.text = @"Track your Crossfit workouts here! You've got this!";
    self.wodDescriptionLabel.text = @"Workout description (including weights, modifications, etc):";
    
    [wodType addTarget:self action:@selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
    wodType.selectedSegmentIndex = 1; // Default to For Time
    [self.view addSubview:wodType];
    
    self.amrapLabel.hidden = YES;
    self.amrapTextBox.hidden = YES;
    self.roundsLabel.hidden = YES;
    self.roundsTextBox.hidden = YES;
    self.repsTextBox.hidden = YES;
    self.plusLabel.hidden = YES;
}

- (void)segmentAction:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0: {
            
            //self.view.backgroundColor = [UIColor blueColor]; //for testing purposes
            self.timeLabel.hidden = YES;
            self.timeTextBox.hidden = YES;
            
            self.amrapLabel.text = @"AMRAP";
            self.amrapLabel.hidden = NO;
            self.amrapTextBox.hidden = NO;
            self.roundsLabel.text = @"Rounds + Reps: ";
            self.roundsLabel.hidden = NO;
            self.roundsTextBox.hidden = NO;
            self.repsTextBox.hidden = NO;
            self.plusLabel.text = @"+";
            self.plusLabel.hidden = NO;
            break;
            
        }
        case 1: {
            
            //self.view.backgroundColor = [UIColor greenColor]; //for testing purposes
            
            self.timeLabel.text = @"Final Time: ";
            self.timeLabel.hidden = NO;
            self.timeTextBox.hidden = NO;
            
            self.amrapLabel.hidden = YES;
            self.amrapTextBox.hidden = YES;
            self.roundsLabel.hidden = YES;
            self.roundsTextBox.hidden = YES;
            self.repsTextBox.hidden = YES;
            self.plusLabel.hidden = YES;
            
            break;
            
        }
        case 2: {
            //self.view.backgroundColor = [UIColor yellowColor]; //for testing purposes
            
            self.timeLabel.hidden = YES;
            self.timeTextBox.hidden = YES;
            
            self.amrapLabel.hidden = YES;
            self.amrapTextBox.hidden = YES;
            self.roundsLabel.hidden = YES;
            self.roundsTextBox.hidden = YES;
            self.repsTextBox.hidden = YES;
            self.plusLabel.hidden = YES;
            break;
        }
        default:
            break;
    }
}

- (IBAction)clickSaveButton:(id)sender {
    //self.view.backgroundColor = [UIColor redColor]; //for testing purposes
    
    //Request access to events
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        
        event.title = @"Crossfit!";
        
        if ([self.timeTextBox.text isEqual:@""] == FALSE)
        {
            event.notes = [NSString stringWithFormat:@"Final Time: %@ \n%@",
             self.timeTextBox.text, self.wodDescription.text];
        }
        else if ([self.amrapTextBox.text isEqual:@""] == FALSE)
        {
            event.notes = [NSString stringWithFormat:@"AMRAP %@ \n%@ \n%@ %@ %@ %@",
             self.amrapTextBox.text, self.wodDescription.text, self.roundsLabel.text, self.roundsTextBox.text, self.plusLabel.text, self.repsTextBox.text];
        }
        else
        {
            event.notes = self.wodDescription.text;
        }
        
        event.startDate = [datePicker date];
        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour event
        
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        
        [self createAlert];
    }];
}

- (void)createAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your workout has been saved to the calendar." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                  [alertView show];
                                  });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
