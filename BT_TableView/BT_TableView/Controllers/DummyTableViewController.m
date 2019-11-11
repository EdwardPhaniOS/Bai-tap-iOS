//
//  DummyTableViewController.m
//  BT_TableView
//
//  Created by iMac_VTCA on 11/11/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "DummyTableViewController.h"

@interface DummyTableViewController ()

@end

@implementation DummyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"%i", indexPath.row);
//    
//}

@end
