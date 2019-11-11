//
//  ViewController.h
//  BT_TableView
//
//  Created by iMac_VTCA on 11/8/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *usersInfo;
    UserInfo *selectedUserInfo;
    int selectedRow;
    
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;


- (IBAction)addPressed:(UIButton *)sender;
- (IBAction)editPressed:(UIButton *)sender;


@end

