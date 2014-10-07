//
//  Coordinates.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Office;

@interface Coordinates : NSManagedObject

@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic, retain) Office *office;

@end
