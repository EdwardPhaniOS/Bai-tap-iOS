//
//  ViewController.h
//  CreateMenuWithTBV
//
//  Created by iMac_VTCA on 11/13/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionModel.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray *arrayItems;
    NSMutableDictionary *numberOfRowDict;
    
    int selectedSection;
}

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end

