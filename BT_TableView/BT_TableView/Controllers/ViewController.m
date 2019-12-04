//
//  ViewController.m
//  BT_TableView
//
//  Created by iMac_VTCA on 11/8/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "ViewController.h"
#import "UserInfo.h"
#import "InfoCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    usersInfo = [[NSMutableArray alloc] init];
    
    [self.infoTableView setRowHeight:120.0];
    
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
}


- (IBAction)addPressed:(UIButton *)sender {
    
    if ([_addButton.titleLabel.text isEqualToString:@"Add"]) {
        
        if ([self.ageTextField.text isEqualToString:@""] || [self.nameTextField.text isEqualToString:@""]) {
            
            //Show alert
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Please fill in your name and age" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:true completion:nil];
            
        } else {
            int age = (int)[self.ageTextField.text integerValue];
            NSString *name = self.nameTextField.text;
            
            UserInfo *userInfo = [[UserInfo alloc] initWithAge:age andName:name];
            [usersInfo addObject:userInfo];
            
            [self clearTextField];
            [self.view endEditing:true];
            
            [self.infoTableView reloadData];
            
            NSIndexPath *index = [NSIndexPath indexPathForItem:usersInfo.count - 1 inSection:0];
            [self.infoTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:true];
        }
        
    } else {
        
        int age = (int)[self.ageTextField.text integerValue];
        NSString *name = self.nameTextField.text;
        
        selectedUserInfo.age = age;
        selectedUserInfo.name = name;
        usersInfo[selectedRow] = selectedUserInfo;
        
        [_infoTableView reloadData];
        
        [self clearTextField];
        selectedUserInfo = nil;
        [self.view endEditing:true];
        [_addButton setTitle:@"Add" forState:UIControlStateNormal];
    }
    
}

- (void)clearTextField {
    [self.ageTextField setText:@""];
    [self.nameTextField setText:@""];
}

- (IBAction)editPressed:(UIButton *)sender {
    
    BOOL isEditing = [_infoTableView isEditing];
    [_infoTableView setEditing:!isEditing];
    
    if (selectedUserInfo != nil) {
        int age = selectedUserInfo.age;
        NSString *name = selectedUserInfo.name;
        
        NSString *ageString = [NSString stringWithFormat:@"%i", age];
        
        [_ageTextField setText:ageString];
        [self.nameTextField setText:name];
        
        if (isEditing) {
            [_addButton setTitle:@"Add" forState:UIControlStateNormal];
        } else {
             [_addButton setTitle:@"Update" forState:UIControlStateNormal];
        }
       
    }

}

//MARK: UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return usersInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    
    if (cell != nil) {
        
        UserInfo *userinfo = (UserInfo *) usersInfo[indexPath.row];
        cell.nameLabel.text = userinfo.name;
        
        NSString *name = [NSString stringWithFormat:@"%i", userinfo.age];
        cell.ageLabel.text = name;
        
        return cell;
        
    } else {
        return [[UITableViewCell alloc] init];
    }
}

//Default Contextual Action (user clicked table view edit)

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [usersInfo removeObjectAtIndex:indexPath.row];
        [_infoTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//MARK: UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedUserInfo = usersInfo[indexPath.row];
    selectedRow = (int)indexPath.row;
}


// Custom Contextual Action (user swipe left or right on table view)

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"Delete pressed");
        [self->usersInfo removeObjectAtIndex:indexPath.row];
        [self->_infoTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    UIContextualAction *rename = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Rename" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"Rename pressed");
    }];
    
    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:[NSArray arrayWithObjects:delete, rename, nil]];
    [swipeActionConfig performsFirstActionWithFullSwipe];
    
    return swipeActionConfig;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIContextualAction *rename = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"Rename" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSLog(@"Rename pressed");
    }];
    
    UISwipeActionsConfiguration *swipeActionsConfig = [UISwipeActionsConfiguration configurationWithActions:[NSArray arrayWithObject:rename]];
    
    return swipeActionsConfig;
}

@end
