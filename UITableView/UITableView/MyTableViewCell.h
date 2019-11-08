//
//  MyTableViewCell.h
//  UITableView
//
//  Created by iMac_VTCA on 11/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coin.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell {
    
    NSMutableArray *selectedArray;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (void)visualizeCell: (Coin*) coin;

@end

NS_ASSUME_NONNULL_END
