//
//  PSRPochtaManager.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 03/10/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"


typedef void(^PSRPochtaCopmlition)(id data, BOOL success);

@interface PSRPochtaManager : AFHTTPRequestOperationManager

- (void)getOfficesOfCount:(int)count complition:(PSRPochtaCopmlition)complitionBlock;


@end
