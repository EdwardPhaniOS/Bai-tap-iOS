//
//  ViewController.m
//  UITableView
//
//  Created by iMac_VTCA on 11/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "Coin.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.dataSource = self;
    
    _myTableView.estimatedRowHeight = 80;
    _myTableView.rowHeight = UITableViewAutomaticDimension;
    
    Coin *coin1 = [[Coin alloc] initWithName:@"coin1" detail:@"digital coin1" imageName:@"pic1"];
    Coin *coin2 = [[Coin alloc] initWithName:@"coin2" detail:@"digital coin2" imageName:@"pic2"];
    Coin *coin3 = [[Coin alloc] initWithName:@"coin3" detail:@"digital coin3" imageName:@"pic3"];
    Coin *coin4 = [[Coin alloc] initWithName:@"coin4" detail:@"digital coin4" imageName:@"pic4"];
    
    myCoins = [[NSMutableArray alloc] initWithObjects:coin1, coin2, coin3, coin4, nil];
}


- (IBAction)AddPressed:(UIButton *)sender {
    
    //create a new coin
    Coin *newCoin = [[Coin alloc] initWithName:@"newCoin" detail:@"New digital coin" imageName:@"pic2"];
    [myCoins addObject:newCoin];
    
    //insert coin to UI
    [_myTableView beginUpdates];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:myCoins.count - 1 inSection:0];
    [_myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [_myTableView endUpdates];
    
    [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:true];
    
}

- (IBAction)EditPressed:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"Edit"]) {
        [_myTableView setEditing:true animated:true];
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
    } else {
        [_myTableView setEditing:false animated:true];
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
    }
    
}

- (IBAction)updatePressed:(UIButton *)sender {
    
    Coin *updatedCoin = [[Coin alloc] initWithName:@"updated coin" detail:@"updated digital coin" imageName:@"pic2"];
    myCoins[0] = updatedCoin;
    
    [_myTableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [_myTableView endUpdates];
    
    [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
}

- (IBAction)reloadData:(UIButton *)sender {
    [_myTableView reloadData];
}

//MARK - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myCoins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    if (myCell != nil) {
        
        //config custom cell
        
        Coin *coin = myCoins[indexPath.row];
        if (coin != nil) {
            
            [myCell.titleLabel setText:coin.name];
            [myCell.detailLabel setText:coin.detail];
            
            UIImage *image = [UIImage imageNamed:coin.imageName];
            [myCell.image setImage:image];
        }
        
        return myCell;
    }
    
    return [[UITableViewCell alloc] init];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        return false;
    }
    
    return true;
}

//Allow move item on UI
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

//Alow move item on UI
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSInteger rowSource = sourceIndexPath.row;
    Coin *coin = myCoins[rowSource];
    [myCoins removeObjectAtIndex:rowSource];
    
    NSInteger rowDes = destinationIndexPath.row;
    [myCoins insertObject:coin atIndex:rowDes];
    
}

@end
