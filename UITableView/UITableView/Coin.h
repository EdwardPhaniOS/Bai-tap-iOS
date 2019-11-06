//
//  Coin.h
//  UITableView
//
//  Created by iMac_VTCA on 11/6/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Coin : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSString *imageName;

- (id)initWithName:(NSString *)name detail:(NSString *)detail imageName:(NSString*)imageName;

@end

NS_ASSUME_NONNULL_END
