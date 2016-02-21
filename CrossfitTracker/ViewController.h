//
//  ViewController.h
//  CrossfitTracker
//
//  Created by Katie Farquhar on 2/20/16.
//  Copyright © 2016 Katie Berner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *wodType;

@property (weak, nonatomic) IBOutlet UITextView *wodDescription;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *timeTextBox;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *amrapLabel;

@property (weak, nonatomic) IBOutlet UITextField *amrapTextBox;

@property (weak, nonatomic) IBOutlet UILabel *roundsLabel;

@property (weak, nonatomic) IBOutlet UITextField *roundsTextBox;

@property (weak, nonatomic) IBOutlet UITextField *repsTextBox;

@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *wodDescriptionLabel;


@end

