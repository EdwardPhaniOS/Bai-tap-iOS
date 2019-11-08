//
//  ViewController.m
//  UIStackViewObjectiveC
//
//  Created by iMac_VTCA on 11/8/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "ViewController.h"
#import "ThirdViewController.h"
#import "MyCellXIB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *nib = [UINib nibWithNibName:@"MyCellXIB" bundle:nil];
    [self.tableView2 registerNib:nib forCellReuseIdentifier:@"myCellXib"];
    
    self.tableView2.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //View 1
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blueColor];
    [view1.heightAnchor constraintEqualToConstant:100].active = true;
    [view1.widthAnchor constraintEqualToConstant:120].active = true;


    //View 2
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor greenColor];
    [view2.heightAnchor constraintEqualToConstant:100].active = true;
    [view2.widthAnchor constraintEqualToConstant:70].active = true;

    //View 3
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor magentaColor];
    [view3.heightAnchor constraintEqualToConstant:100].active = true;
    [view3.widthAnchor constraintEqualToConstant:180].active = true;

    //Stack View
    UIStackView *stackView = [[UIStackView alloc] init];

    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 30.0;

    [stackView addArrangedSubview:view1];
    [stackView addArrangedSubview:view2];
    [stackView addArrangedSubview:view3];

    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:stackView];
    
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
    
}

- (IBAction)goPressed:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"ToSecondView" sender:self];
}

- (IBAction)goToXIB:(UIButton *)sender {
    ThirdViewController *thirdVC = [[ThirdViewController alloc] initWithNibName:nil bundle:nil];
    thirdVC.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:thirdVC animated:true completion:nil];
    
}


//MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCellXIB *myCellXib = [tableView dequeueReusableCellWithIdentifier:@"myCellXib"];
    
    if (myCellXib != nil) {
        return myCellXib;
    }
    
    return [[UITableViewCell alloc] init];
}

@end
