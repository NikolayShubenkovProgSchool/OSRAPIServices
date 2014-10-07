//
//  DetailedInfo.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DetailedInfo : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSManagedObject *office;

@end
