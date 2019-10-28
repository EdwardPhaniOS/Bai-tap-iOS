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

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
}

- (IBAction)submitButtonPressed:(UIButton *)sender {
    NSString *firstname = _firstnameTextField.text;
//        NSString *lastname;
//        NSString *gender;
//        NSString *Age;
//        NSString *experience;
//        NSString *numberOfCompany;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
        if (textField.tag == 1) {
            [self.lastnameTextField becomeFirstResponder];
        } else {
            [self.view endEditing:true];
            
        }
    
    return true;
}


@end
