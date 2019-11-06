//
//  Coin.m
//  UITableView
//
//  Created by iMac_VTCA on 11/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import "Coin.h"

@implementation Coin 

- (id)initWithName:(NSString *)name detail:(NSString *)detail imageName:(NSString *)imageName {
    self = [super init];
    self.name = name;
    self.detail = detail;
    self.imageName = imageName;
    
    return self;
}
@end
