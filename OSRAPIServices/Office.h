//
//  Office.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DetailedInfo;

@interface Office : NSManagedObject

@property (nonatomic, retain) NSString * idValue;
@property (nonatomic, retain) NSString * title;
@property (nonatomic) BOOL opened;
@property (nonatomic, retain) NSManagedObject *coordinates;
@property (nonatomic, retain) DetailedInfo *info;

@end
