//
//  Office+Fetch.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 07/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "Office.h"

@interface Office (Fetch)

+ (Office *)officeWithInfo:(NSDictionary *)info inContenxt:(NSManagedObjectContext *)context;

@end
