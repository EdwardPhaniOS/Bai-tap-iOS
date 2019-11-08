//
//  MyTableViewCell.m
//  UITableView
//
//  Created by iMac_VTCA on 11/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "MyTableViewCell.h"


@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.image.image = nil;
    self.detailLabel.text = nil;
    self.detailLabel.text = nil;
}

- (void)visualizeCell: (Coin*) coin {
    
    [self.titleLabel setText:coin.name];
    [self.detailLabel setText:coin.detail];
    
    UIImage *image = [UIImage imageNamed:coin.imageName];
    [self.image setImage:image];
    
}

@end
