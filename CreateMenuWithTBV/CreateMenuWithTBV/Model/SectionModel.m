//
//  SectionModel.m
//  CreateMenu
//
//  Created by Tan Vinh Phan on 11/13/19.
//  Copyright © 2019 PTV. All rights reserved.
//

#import "SectionModel.h"

@implementation SectionModel

- (id)initWithName:(NSString *)name andNumberOfRows:(int)numberOfRow {
    self = [super init];
    if (self) {
        self.name = name;
        self.numberOfRow = numberOfRow;
    }
    return self;
}

@end
