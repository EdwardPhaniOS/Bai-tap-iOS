//
//  ViewController.h
//  UITableView
//
//  Created by iMac_VTCA on 11/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController <UITableViewDataSource> {
    NSMutableArray *myCoins;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)AddPressed:(UIButton *)sender;
- (IBAction)EditPressed:(UIButton *)sender;
- (IBAction)updatePressed:(UIButton *)sender;
- (IBAction)reloadData:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
