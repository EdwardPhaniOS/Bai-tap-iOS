//
//  SecondViewController.m
//  UIStackViewObjectiveC
//
//  Created by iMac_VTCA on 11/8/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)backPressed:(UIButton *)sender {
//    [self.navigationController popToRootViewControllerAnimated:true];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)switchToXib:(UIButton *)sender {
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithNibName:nil bundle:nil];
//    thirdVC.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:thirdVC animated:true completion:nil];
    
}
@end
