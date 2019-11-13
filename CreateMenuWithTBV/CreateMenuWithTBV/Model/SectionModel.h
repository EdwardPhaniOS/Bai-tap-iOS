//
//  SectionModel.h
//  CreateMenu
//
//  Created by Tan Vinh Phan on 11/13/19.
//  Copyright © 2019 PTV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionModel : NSObject

@property (assign) NSString *name;
@property (assign) int numberOfRow;

- (id) initWithName: (NSString *)name andNumberOfRows: (int)rows;

@end

NS_ASSUME_NONNULL_END
