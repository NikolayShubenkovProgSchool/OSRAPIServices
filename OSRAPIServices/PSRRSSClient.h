//
//  PSRRSSClient.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 30/09/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef void(^PSRRSSCopmlition)(id data, BOOL success);

@interface PSRRSSClient : AFHTTPRequestOperationManager

- (void)getRSSFromURL:(NSString *)url withComplition:(PSRRSSCopmlition)copmlitionBlock;

@end
