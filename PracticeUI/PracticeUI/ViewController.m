//
//  ViewController.m
//  PracticeUI
//
//  Created by iMac_VTCA on 10/28/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (IBAction)swichValueChanged:(UISwitch *)sender {
    if (sender.isOn) {
        self.genderLabel.text = @"Male";
    } else {
        self.genderLabel.text = @"Female";
    }
}

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    NSString *resultString = [NSString stringWithFormat:@"%i", (int)sender.value];
    self.ageLabel.text = resultString;
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSString *resultString = [NSString stringWithFormat:@"%i", (int)sender.value];
    self.experienceLabel.text = resultString;
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    [self.view endEditing:true];
    [_summaryTextView setHidden:true];
    
    NSString *firstname = _firstnameTextField.text;
    NSString *lastname = _lastnameTextField.text;
    
    if ([firstname isEqualToString:@""] || [lastname isEqualToString:@""]) {
        [self showAlert];
    } else {
        NSString *gender = _genderLabel.text;
        NSString *age = _ageLabel.text;
        NSString *experience = _experienceLabel.text;
        NSInteger totalCompany = _numberOfCompanySegment.selectedSegmentIndex + 1;
        
        finalString = [NSString stringWithFormat:@"First name: %@, Last name: %@, Gender: %@, Age: %@, Experience: %@ year(s), Number of company: %li", firstname, lastname, gender, age, experience, (long)totalCompany];
        [_summaryTextView setText:finalString];
        
        count = 0;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress) userInfo:nil repeats:true];
        
        [_loadingIndicator setHidden:false];
        [_loadingIndicator startAnimating];
        
        [_progressBar setHidden:false];
    }
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Please fill in your first name and last name" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}

- (void)updateProgress {
    count += 1;
    
    if (count < 10 ) {
        _progressBar.progress = _progressBar.progress + 0.1;
    } else {
        [myTimer invalidate];
        myTimer = nil;
        [_progressBar setHidden:true];
        [_loadingIndicator stopAnimating];
        [self showResult];
    }
    
}

- (void)showResult {
    [_summaryTextView setHidden:false];
    [self restartForm];
}

- (void)restartForm {
    count = 0;
    [_firstnameTextField setText:@""];
    [_lastnameTextField setText:@""];
    _progressBar.progress = 0;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_summaryTextView setHidden:true];
    
    [self.view endEditing:true];
    
    return true;
}


@end


