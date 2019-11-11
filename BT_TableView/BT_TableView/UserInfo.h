//
//  UserInfo.h
//  BT_TableView
//
//  Created by iMac_VTCA on 11/11/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject {

}

@property (assign) int age;
@property (assign) NSString *name;

- (id) initWithAge: (int)age andName: (NSString *)name;

@end

NS_ASSUME_NONNULL_END
