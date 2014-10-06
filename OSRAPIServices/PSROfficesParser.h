//
//  PSROfficesParser.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

//put here to notify about parsed object class
@class PSROffice;

@interface PSROfficesParser : NSObject

- (NSArray *)officesFromInfoes:(NSArray *)infoes;

@end
