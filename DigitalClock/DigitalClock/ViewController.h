//
//  ViewController.h
//  DigitalClock
//
//  Created by Tan Vinh Phan on 10/29/19.
//  Copyright © 2019 PTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSTimer *timer;
    int count;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *record;
@property (weak, nonatomic) IBOutlet UIButton *startButton;



- (IBAction)startTimer:(UIButton *)sender;
- (IBAction)restart:(UIButton *)sender;
- (IBAction)recordPressed:(UIButton *)sender;

@end
