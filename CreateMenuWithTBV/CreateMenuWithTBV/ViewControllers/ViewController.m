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
    
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    
    //remove empty row at bottom
    self.menuTableView.tableFooterView = [[UIView alloc] init];
}

//MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arrayItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:section];
    return mySection.numberOfRow;
    

//    if (selectedSection == -1) {
//        return 0;
//    } else if (section == selectedSection) {
//        SectionModel *mySection = [arrayItems objectAtIndexedSubscript:selectedSection];
//        return mySection.numberOfRow;
//    } else {
//        return 0;
//    }
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

    if (mySection.numberOfRow == 0) {
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
    NSString *indexString = [NSString stringWithFormat:@"%i", index];
    
    //if current arrow is right arrow
    if (sender.imageView.image == [UIImage systemImageNamed:@"arrowtriangle.right.fill"]) {

        //change to down arrow
        UIImage *downArrow = [UIImage systemImageNamed:@"arrowtriangle.down.fill"];
        [sender setImage:downArrow forState:UIControlStateNormal];

        SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];

        //get number of rows from dictionary
        int number = [[numberOfRowDict objectForKey:indexString] intValue];
        mySection.numberOfRow = number;

        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
        [self.menuTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    } else {
        //change to right arrow
        UIImage *rightArrow = [UIImage systemImageNamed:@"arrowtriangle.right.fill"];
        [sender setImage:rightArrow forState:UIControlStateNormal];

        SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];

        //save number of rows to dictionary
        int numberOfRows = (int)mySection.numberOfRow;
        NSNumber *number = [[NSNumber alloc] initWithInt:numberOfRows];
        [numberOfRowDict setValue:number forKey:indexString];

        mySection.numberOfRow = 0;

        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
        [self.menuTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    //Muon 1 cai bat, cac cai con lai dong hoac muon loat lan luot tung cai thi:
    
    //Yourarray.append([labeltext])
    //Then upate your table and insert new row
//    tableView.beginUpdates()
//    tableView.insertRows(at: [IndexPath(row: yourArray.count-1, section: 0)], with: .automatic)
//    tableView.endUpdates()
    
    
//    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];
    
}

- (void) addButtonPressed: (UIButton *)sender {
    
    int index = (int)sender.tag;
    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];
    mySection.numberOfRow += 1;
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
    [self.menuTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void) minusButtonPressed: (UIButton *)sender {

    int index = (int)sender.tag;
    SectionModel *mySection = [arrayItems objectAtIndexedSubscript:index];
    
    if (mySection.numberOfRow > 0) {
        mySection.numberOfRow -= 1;
    }
    
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
    [self.menuTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end


