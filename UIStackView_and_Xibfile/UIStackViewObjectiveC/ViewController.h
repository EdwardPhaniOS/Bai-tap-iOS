//
//  ViewController.h
//  UIStackViewObjectiveC
//
//  Created by iMac_VTCA on 11/8/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;


- (IBAction)goPressed:(UIButton *)sender;
- (IBAction)goToXIB:(UIButton *)sender;

@end

