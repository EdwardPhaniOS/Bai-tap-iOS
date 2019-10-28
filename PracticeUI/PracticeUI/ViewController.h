//
//  ViewController.h
//  PracticeUI
//
//  Created by iMac_VTCA on 10/28/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate> {
//    NSString *firstname;
//    NSString *lastname;
//    NSString *gender;
//    NSString *Age;
//    NSString *experience;
//    NSString *numberOfCompany;
    
    NSString *finalString;
}

@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;


- (IBAction)swichValueChanged:(UISwitch *)sender;
- (IBAction)stepperValueChanged:(UIStepper *)sender;
- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)segmentValueChanged:(UISegmentedControl *)sender;
- (IBAction)submitButtonPressed:(UIButton *)sender;


@end

