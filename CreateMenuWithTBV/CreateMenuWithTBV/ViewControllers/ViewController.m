//
//  ViewController.m
//  CreateMenuWithTBV
//
//  Created by iMac_VTCA on 11/13/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "ViewController.h"
#import "MenuCell.h"
#import "SectionModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedSection = -1;
    
    SectionModel *section1 = [[SectionModel alloc] initWithName:@"Section 1" andNumberOfRows:2];
    SectionModel *section2 = [[SectionModel alloc] initWithName:@"Section 2" andNumberOfRows:3];
    SectionModel *section3 = [[SectionModel alloc] initWithName:@"Section 3" andNumberOfRows:4];
    
    arrayItems = [NSMutableArray arrayWithObjects:section1, section2, section3, nil];
    
    numberOfRowDict = [[NSMutableDictionary alloc]initWithCapacity:arrayItems.count];
    
    //Save number of rows to dictionary
    int count = -1;
    for (SectionModel *section in arrayItems) {
        count += 1;
        
        [self saveNumberOfRowsToDict:section.numberOfRow atIndex:count];
    }
    
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    //Remove empty row at bottom
    self.menuTableView.tableFooterView = [[UIView alloc] init];
}

//MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrayItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (selectedSection == -1) {
        return 0;
    } else if (section == selectedSection) {
        SectionModel *mySection = [arrayItems objectAtIndexedSubscript:selectedSection];
        return mySection.numberOfRow;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    if (cell != nil) {
        NSString *text = [NSString stringWithFormat:@"Section %li - row %li", indexPath.section + 1, indexPath.row + 1];
        [cell.label setText:text];
        return cell;
        
    } else {
        return [[UITableViewCell alloc] init];
    }
}

//MARK: - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    /* Create custom view to display section header... */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    [view setBackgroundColor:UIColor.grayColor];
    
    // Create custom label in custom view
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 20)];
    NSString *text = [NSString stringWithFormat:@"Section %li", (long)section + 1];
    [label setText:text];
    [label setTextColor:UIColor.blackColor];
    
    [view addSubview:label];
    
    // Create arrow button in custom view
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 5, 60, 20)];
    
    UIImage *arrowImage = [UIImage systemImageNamed:@"arrowtriangle.down.fill"];
    
    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:section];
    
    if (selectedSection == -1 || mySection.numberOfRow == 0 || selectedSection != section) {
        arrowImage = [UIImage systemImageNamed:@"arrowtriangle.right.fill"];
    }
    
    [detailButton setImage:arrowImage forState:UIControlStateNormal];
    detailButton.tintColor = UIColor.blackColor;
    [detailButton addTarget:self action:@selector(arrowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    detailButton.tag = section;
    
    [view addSubview:detailButton];
    
    // Create add button in custom view
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 2, 60, 20)];
    UIImage *addImage = [UIImage systemImageNamed:@"plus.app.fill"];;
    [addButton setImage:addImage forState:UIControlStateNormal];
    [addButton setTintColor:UIColor.blackColor];
    [addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = section;
    
    [view addSubview:addButton];
    
    // Create remove button in custom view
    UIButton *removeButton = [[UIButton alloc] initWithFrame:CGRectMake(320, 2, 60, 20)];
    UIImage *removeImage = [UIImage systemImageNamed:@"minus.square.fill"];
    [removeButton setImage:removeImage forState:UIControlStateNormal];
    [removeButton setTintColor:UIColor.blackColor];
    [removeButton addTarget:self action:@selector(minusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    removeButton.tag = section;
    
    [view addSubview:removeButton];
    
    return view;
}

- (void) arrowButtonPressed: (UIButton *)sender {
    
    int index = (int)sender.tag;
    selectedSection = index;
    
    //If current arrow is right arrow
    if (sender.imageView.image == [UIImage systemImageNamed:@"arrowtriangle.right.fill"]) {

        //Change to down arrow
        UIImage *downArrow = [UIImage systemImageNamed:@"arrowtriangle.down.fill"];
        [sender setImage:downArrow forState:UIControlStateNormal];

        SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];

        //Get number of rows from dictionary then update rows on UI
        int number = [self getNumberOfRowsFromDictWithKey:index];
        mySection.numberOfRow = number;
        [self.menuTableView reloadData];

    } else {
        //Change to right arrow
        UIImage *rightArrow = [UIImage systemImageNamed:@"arrowtriangle.right.fill"];
        [sender setImage:rightArrow forState:UIControlStateNormal];

        SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];

        //Save number of rows to dictionary then remove rows on UI
        [self saveNumberOfRowsToDict:(int)mySection.numberOfRow atIndex:index];
        mySection.numberOfRow = 0;
        [self.menuTableView reloadData];
    }
    
}

- (void) addButtonPressed: (UIButton *)sender {
    
    int index = (int)sender.tag;
    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];
    mySection.numberOfRow += 1;
    [self saveNumberOfRowsToDict:mySection.numberOfRow atIndex:index];
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
    [self.menuTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void) minusButtonPressed: (UIButton *)sender {

    int index = (int)sender.tag;
    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];
    
    if (mySection.numberOfRow > 0) {
        mySection.numberOfRow -= 1;
        [self saveNumberOfRowsToDict:mySection.numberOfRow atIndex:index];
    }
    
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
    [self.menuTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)saveNumberOfRowsToDict: (int)numbers atIndex: (int)index {
    NSString *key = [NSString stringWithFormat:@"%i", index];
    NSNumber *nsNumber = [[NSNumber alloc] initWithInt:numbers];
    [numberOfRowDict setValue:nsNumber forKey:key];
}

- (int)getNumberOfRowsFromDictWithKey: (int)index {
    NSString *key = [NSString stringWithFormat:@"%i", index];
    int number = [[numberOfRowDict objectForKey:key] intValue];
    return number;
}

@end


