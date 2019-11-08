//
//  ViewController.h
//  BT_TableView
//
//  Created by iMac_VTCA on 11/8/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;


- (IBAction)addPressed:(UIButton *)sender;
- (IBAction)editPressed:(UIButton *)sender;


@end

