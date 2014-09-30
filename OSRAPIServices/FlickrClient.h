//
//  FlickrClient.h
//  OSRAPIServices
//
//  Created by n.shubenkov on 30/09/14.
//  Copyright (c) 2014 n.shubenkov. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef void(^PSRFlickrCopmlition)(id data, BOOL success);

@interface FlickrClient : AFHTTPRequestOperationManager

- (void)getPhotosWithTag:(NSString *)tag complition:(PSRFlickrCopmlition)complitionBlock;

@end
