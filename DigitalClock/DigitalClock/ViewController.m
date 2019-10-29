//
//  ViewController.m
//  DigitalClock
//
//  Created by Tan Vinh Phan on 10/29/19.
//  Copyright © 2019 PTV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)updateTimer {
    count ++;
    
    int min = floor(count/100/60);
    int sec = floor(count/100);
    int mSec =count % 100;
    
    if (sec >= 60) {
        sec = sec % 100;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", min, sec, mSec];
}

- (IBAction)startTimer:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"Start"]) {
        
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTimer) userInfo:nil repeats:true];

    } else if ([sender.titleLabel.text isEqualToString:@"Stop"]){

        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [timer invalidate];
        timer = nil;
    }
}

- (IBAction)restart:(UIButton *)sender {
    [self.timeLabel setText:@"00:00:00"];
    [self.record setText:@""];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    
    count = 0;
    
    [timer invalidate];
    timer = nil;
}

- (IBAction)recordPressed:(UIButton *)sender {
    
    NSString *records;
    
    if ([self.record.text isEqualToString:@""]) {
        records = [NSString stringWithFormat:@"%@", self.timeLabel.text];
    } else {
        records = [NSString stringWithFormat:@"%@, %@", self.record.text, self.timeLabel.text];
    }
    
    [self.record setText:records];
}
@end

